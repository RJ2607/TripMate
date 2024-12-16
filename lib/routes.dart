import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/navigationController.dart';
import 'package:tripmate/views/Auth/loginPage.dart';
import 'package:tripmate/views/Home/homeScreen.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/addTrip.dart';
import 'package:tripmate/views/My%20Trip/myTripPage.dart';
import 'package:tripmate/views/Profile/profilePage.dart';
import 'package:tripmate/views/navBarMenu.dart';

import 'views/onboardingScreen.dart';

class RouteGenerator {
  NavigationController navigationController = Get.put(NavigationController());

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/navigation':
        return MaterialPageRoute(builder: (_) => NavigationView());
      case '/mytrip':
        return MaterialPageRoute(builder: (_) => const MyTrip());
      // case '/maps':
      //   return MaterialPageRoute(builder: (_) => const MapsPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());
      case '/addTrips':
        return MaterialPageRoute(builder: (_) => AddTrips());
      // case '/addTrip/daySection':
      //   return MaterialPageRoute(builder: (_) => DaySelect());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
