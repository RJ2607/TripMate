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

List<NavigationModel> bottomNavItems = [
  NavigationModel(
    title: 'Home',
    icon: Iconsax.home_2_outline,
    isActived: true,
    iconActiveColor: const Color(0xFF43A047),
    iconColor: Colors.black,
  ),
  NavigationModel(
    title: 'Trips',
    icon: Iconsax.airplane_outline,
    isActived: false,
    iconActiveColor: const Color(0xFF43A047),
    iconColor: Colors.black,
  ),
  NavigationModel(
    title: 'Budget',
    icon: Iconsax.dollar_square_outline,
    isActived: false,
    iconActiveColor: const Color(0xFF519E67),
    iconColor: Colors.black,
  ),
  NavigationModel(
    title: 'Settings',
    icon: Iconsax.setting_2_outline,
    isActived: false,
    iconActiveColor: const Color(0xFF519E67),
    iconColor: Colors.black,
  ),
];
