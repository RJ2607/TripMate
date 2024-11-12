import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NavigationModel {
  String title;
  IconData icon;
  bool isActived;
  Color iconActiveColor;
  Color iconColor;

  NavigationModel({
    required this.title,
    required this.icon,
    required this.isActived,
    required this.iconActiveColor,
    required this.iconColor,
  });
}

List<NavigationModel> bottomNavItemsDark = [
  NavigationModel(
    title: 'Home',
    icon: Iconsax.home_bold,
    isActived: true,
    iconActiveColor: const Color(0xFF519E67),
    iconColor: Colors.white,
  ),
  NavigationModel(
    title: 'Statistics',
    icon: BoxIcons.bx_trip,
    isActived: false,
    iconActiveColor: const Color(0xFF519E67),
    iconColor: Colors.white,
  ),
  NavigationModel(
    title: 'Settings',
    icon: Iconsax.user_bold,
    isActived: false,
    iconActiveColor: const Color(0xFF519E67),
    iconColor: Colors.white,
  ),
];

List<NavigationModel> bottomNavItemsLight = [
  NavigationModel(
    title: 'Home',
    icon: Iconsax.home_bold,
    isActived: true,
    iconActiveColor: const Color(0xFF004E15),
    iconColor: Colors.black,
  ),
  NavigationModel(
    title: 'Statistics',
    icon: Iconsax.graph_outline,
    isActived: false,
    iconActiveColor: const Color(0xFF004E15),
    iconColor: Colors.black,
  ),
  NavigationModel(
    title: 'Settings',
    icon: Iconsax.setting_2_outline,
    isActived: false,
    iconActiveColor: const Color(0xFF004E15),
    iconColor: Colors.black,
  ),
];
