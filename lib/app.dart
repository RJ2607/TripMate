import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/utils/theme.dart';
import 'package:tripmate/views/navBarMenu.dart';
import 'package:tripmate/views/onboardingScreen.dart';

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const NavBarMenu();
          }
          return const OnboardingScreen();
        },
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      darkTheme: TFlexTheme.darkTheme,
      theme: TFlexTheme.lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}
