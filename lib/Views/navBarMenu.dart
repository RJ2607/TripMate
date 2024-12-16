import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../controller/navigationController.dart';
import '../models/navigationModel.dart';
import 'Home/homeScreen.dart';
import 'My Trip/myTripPage.dart';
import 'Profile/profilePage.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: navigationController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            MyTrip(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  SafeArea buildBottomNavBar(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.7,
            padding:
                const EdgeInsets.only(left: 15, top: 9, right: 15, bottom: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomNavItemsDark.length, (i) {
                NavigationModel navBar = bottomNavItemsDark[i];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    navigationController.updateSelectedBtmNav(navBar, i);
                  },
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimateBar(
                              isActived:
                                  navigationController.currentIndex.value == i,
                            ),
                            Icon(
                              navBar.icon,
                              color:
                                  navigationController.currentIndex.value == i
                                      ? navBar.iconActiveColor
                                      : navBar.iconColor,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                      )),
                );
              }),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/addTrips');
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Iconsax.add_outline,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
        ],
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
      height: MediaQuery.of(context).size.height * 0.005,
      width: isActived ? MediaQuery.of(context).size.width * 0.05 : 0,
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
