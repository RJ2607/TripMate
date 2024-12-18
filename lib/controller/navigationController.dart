import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/navigationModel.dart';

class NavigationController extends GetxController {
  Rx<int> currentIndex = 0.obs;

  NavigationModel selectedBottomNav = bottomNavItemsDark.first;

  Rx<PageController> pageController = PageController().obs;

  /// Updates the selected bottom navigation item
  void updateSelectedBtmNav(NavigationModel menu, int index) {
    if (currentIndex.value != index || selectedBottomNav != menu) {
      if (index >= 0 && index < bottomNavItemsDark.length) {
        selectedBottomNav = menu;
        currentIndex.value = index;

        pageController.value.animateToPage(
          index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );

        log('Navigation Updated: Index=$currentIndex, Menu=${menu.title}');
        update();
      } else {
        log('Invalid Index: $index');
      }
    }
  }

  /// Changes the page and updates the controller state
  void changePage(int index) {
    if (index >= 0 && index < bottomNavItemsDark.length) {
      currentIndex.value = index;

      // Ensure `pageController` is updated
      pageController.value.jumpToPage(index);

      log('Page Changed: Index=$currentIndex');
      update();
    } else {
      log('Invalid Index: $index');
    }
  }

  /// Goes to the next page, if within bounds
  void nextPage() {
    if (currentIndex < bottomNavItemsDark.length - 1) {
      currentIndex.value++;
      pageController.value.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      log('Navigated to Next Page: Index=$currentIndex');
      update();
    } else {
      log('Already at the last page');
    }
  }

  /// Goes to the previous page, if within bounds
  void previousPage() {
    if (currentIndex > 0) {
      currentIndex.value--;
      pageController.value.previousPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      log('Navigated to Previous Page: Index=$currentIndex');
      update();
    } else {
      log('Already at the first page');
    }
  }
}
