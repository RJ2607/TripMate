import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Views/onboardingScreen.dart';
import 'package:tripmate/utils/theme.dart';

import 'routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trip Mate',
      useInheritedMediaQuery: true,
      home: OnboardingScreen(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      darkTheme: TFlexTheme.darkTheme,
      theme: TFlexTheme.lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}
