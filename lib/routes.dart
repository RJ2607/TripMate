import 'package:flutter/material.dart';
import 'package:tripmate/views/Auth/loginPage.dart';
import 'package:tripmate/views/Home/homeScreen.dart';
import 'package:tripmate/views/Maps/mapPage.dart';
import 'package:tripmate/views/My%20Trip/myTripPage.dart';
import 'package:tripmate/views/Profile/profilePage.dart';

import 'views/navBarMenu.dart';
import 'views/onboardingScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/navigation':
        return MaterialPageRoute(builder: (_) => NavBarMenu());
      case '/mytrip':
        return MaterialPageRoute(builder: (_) => MyTrip());
      case '/maps':
        return MaterialPageRoute(builder: (_) => Maps());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: const Text('Page not found'),
        ),
      );
    });
  }
}
