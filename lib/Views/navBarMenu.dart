import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:tripmate/models/navigationModel.dart';
import 'package:tripmate/utils/responsive.dart';
import 'package:tripmate/views/Budget/budgetPage.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controller/navigationController.dart';
import 'Home/homeScreen.dart';
import 'My Trip/myTripPage.dart';
import 'Home/Profile/profilePage.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());

  final Location _locationController = Location();

  @override
  void initState() {
    super.initState();
    getLocationPermission();
  }

  Future<void> getLocationPermission() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted =
        await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Align(
        alignment: Alignment(0, 0.93.sH(context)),
        child: ZoomTapAnimation(
          endCurve: Curves.bounceInOut,
          beginCurve: Curves.bounceInOut,
          endDuration: const Duration(milliseconds: 200),
          beginDuration: const Duration(milliseconds: 200),
          onTap: () => Get.toNamed('/addTrips'),
          child: Container(
            height: 63.sH(context),
            width: 63.sH(context),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.add_outline,
              color: Colors.white,
              size: 30.sW(context),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: navigationController.pageController.value,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            MyTrip(),
            BudgetPage(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Container(
      height: 64.sH(context),
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 12.sH(context),
        bottom: 13.sH(context),
        right: 28.sW(context),
        left: 28.sW(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 104,
            offset: Offset(0, -10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavIcons(
            navigationController: navigationController,
            index: 0,
          ),
          SizedBox(
            width: 38.sW(context),
          ),
          NavIcons(
            navigationController: navigationController,
            index: 1,
          ),
          SizedBox(
            width: 108.sW(context),
          ),
          NavIcons(
            navigationController: navigationController,
            index: 2,
          ),
          SizedBox(
            width: 38.sW(context),
          ),
          NavIcons(
            navigationController: navigationController,
            index: 3,
          ),
        ],
      ),
    );
  }
}

class NavIcons extends StatefulWidget {
  const NavIcons({
    super.key,
    required this.index,
    required this.navigationController,
  });

  final int index;
  final NavigationController navigationController;

  @override
  State<NavIcons> createState() => _NavIconsState();
}

class _NavIconsState extends State<NavIcons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.navigationController.changePage(widget.index),
      child: Obx(
        () => Column(
          children: [
            AnimateBar(
                isActived: widget.navigationController.currentIndex.value ==
                    widget.index),
            Icon(
              bottomNavItems[widget.index].icon,
              size: 30.sW(context),
              color:
                  widget.navigationController.currentIndex.value == widget.index
                      ? bottomNavItems[widget.index].iconActiveColor
                      : bottomNavItems[widget.index].iconColor,
            )
          ],
        ),
      ),
    );
  }
}

class AnimateBar extends StatelessWidget {
  const AnimateBar({
    required this.isActived,
    super.key,
  });

  final bool isActived;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 5.sH(context),
      width: isActived ? 24.sW(context) : 0,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.75),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
