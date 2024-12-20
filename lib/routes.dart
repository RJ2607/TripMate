import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/navigationController.dart';
import 'package:tripmate/views/Auth/loginPage.dart';
import 'package:tripmate/views/Home/homeScreen.dart';
import 'package:tripmate/views/Maps/mapPage.dart';
import 'package:tripmate/views/My%20Trip/activity/addActivity.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/activity%20details%20page/lodgingDetailsPage.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/activity%20details%20page/restaurantDetailsPage.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/activity%20details%20page/sightseeingDetailsPage.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/daySelect.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/addTrip.dart';
import 'package:tripmate/views/My%20Trip/myTripPage.dart';
import 'package:tripmate/views/Profile/profilePage.dart';
import 'package:tripmate/views/navBarMenu.dart';

import 'utils/customPageRoute.dart';
import 'views/My Trip/activity/day activity/activity details page/transportDetailsPage.dart';
import 'views/My Trip/activity/day activity/dayActivity.dart';
import 'views/onboardingScreen.dart';

class RouteGenerator {
  NavigationController navigationController = Get.put(NavigationController());

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CustomPageRoute(
            child: const OnboardingScreen(),
            transitionType: 'slide',
            settings: settings);
      case '/login':
        return CustomPageRoute(
            child: const LoginPage(),
            transitionType: 'slide',
            settings: settings);
      case '/home':
        return CustomPageRoute(
            child: const HomeScreen(),
            transitionType: 'slide',
            settings: settings);
      case '/navigation':
        return CustomPageRoute(
            child: const NavigationView(),
            transitionType: 'slide',
            settings: settings);
      case '/mytrip':
        return CustomPageRoute(
            child: const MyTrip(), transitionType: 'slide', settings: settings);
      case '/mytrip/daySelect':
        return CustomPageRoute(
            child: DaySelect(), transitionType: 'slide', settings: settings);
      case '/mytrip/daySelect/dayActivity':
        return CustomPageRoute(
            child: DayActivity(),
            direction: AxisDirection.up,
            transitionType: 'slide',
            settings: settings);
      case '/mytrip/daySelect/dayActivity/addActivity':
        return CustomPageRoute(
            child: AddActivity(),
            direction: AxisDirection.left,
            transitionType: 'slide',
            settings: settings);
      case '/mytrip/daySelect/dayActivity/transport':
        return CustomPageRoute(
            child: TransportDetailsPage(),
            direction: AxisDirection.up,
            transitionType: 'slide',
            settings: settings);
      case '/mytrip/daySelect/dayActivity/lodging':
        return CustomPageRoute(
            child: LodgingDetailsPage(),
            direction: AxisDirection.up,
            transitionType: 'slide',
            settings: settings);
      case '/mytrip/daySelect/dayActivity/restaurant':
        return CustomPageRoute(
            child: RestaurantDetailsPage(),
            direction: AxisDirection.up,
            transitionType: 'slide',
            settings: settings);
      case '/mytrip/daySelect/dayActivity/sightseeing':
        return CustomPageRoute(
            child: SightseeingDetailsPage(),
            direction: AxisDirection.up,
            transitionType: 'slide',
            settings: settings);
      case '/profile':
        return CustomPageRoute(
            child: const Profile(),
            transitionType: 'slide',
            settings: settings);
      case '/addTrips':
        return CustomPageRoute(
            child: AddTrips(),
            transitionType: 'slide',
            settings: settings,
            direction: AxisDirection.down);
      case '/maps':
        return CustomPageRoute(
            child: MapsPage(), transitionType: 'slide', settings: settings);

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
