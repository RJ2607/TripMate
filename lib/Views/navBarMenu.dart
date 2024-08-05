import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/views/Home/homeScreen.dart';
import 'package:tripmate/views/My%20Trip/myTripPage.dart';

import 'Maps/mapPage.dart';
import 'Profile/profilePage.dart';

class NavBarMenu extends StatefulWidget {
  const NavBarMenu({super.key});

  @override
  State<NavBarMenu> createState() => _NavBarMenuState();
}

class _NavBarMenuState extends State<NavBarMenu> {
  int _selectedindex = 0;
  late PageController _pagecontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pagecontroller = PageController(initialPage: _selectedindex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: FlashyTabBar(
              height: MediaQuery.of(context).size.height * 0.074,
              animationDuration: const Duration(milliseconds: 500),
              backgroundColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .backgroundColor as Color,
              showElevation: true,
              iconSize: MediaQuery.of(context).size.width * 0.06,
              shadows: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
              onItemSelected: (index) => setState(() {
                _selectedindex = index;
                _pagecontroller.jumpToPage(index);
              }),
              items: [
                FlashyTabBarItem(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor as Color,
                  inactiveColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor as Color,
                  icon: Icon(
                    BoxIcons.bx_home,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor as Color,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor as Color,
                  inactiveColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor as Color,
                  icon: Icon(
                    BoxIcons.bx_trip,
                  ),
                  title: Text(
                    'My Trips',
                    style: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor as Color,
                    ),
                  ),
                ),
                FlashyTabBarItem(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor as Color,
                  inactiveColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor as Color,
                  icon: Icon(BoxIcons.bx_map,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Map',
                    style: TextStyle(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor as Color,
                        fontSize: MediaQuery.of(context).size.width * 0.043),
                  ),
                ),
                FlashyTabBarItem(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor as Color,
                  inactiveColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor as Color,
                  icon: Icon(
                    BoxIcons.bx_user,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor as Color,
                        fontSize: MediaQuery.of(context).size.width * 0.043),
                  ),
                ),
              ],
              selectedIndex: _selectedindex,
            ),
            body: PageView(
              controller: _pagecontroller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                MyTrip(),
                Maps(),
                Profile(),
              ],
            )));
  }
}
