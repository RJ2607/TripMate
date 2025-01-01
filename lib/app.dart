import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmate/utils/colors.dart';
import 'package:tripmate/views/navBarMenu.dart';

import 'routes.dart';
import 'utils/responsive.dart';
import 'views/onboardingScreen.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    Responsive.clearInstance();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
    final responsive = Responsive.getInstance(context: context);
  }

  @override
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
            return NavigationView();
          }
          return const OnboardingScreen();
        },
      ),
      // home: HomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
          primaryColor: TColors.primary,
          hoverColor: TColors.accent,
          scaffoldBackgroundColor: TColors.background,
          fontFamily: GoogleFonts.jost().fontFamily,
          hintColor: TColors.subTextColor),
    );
  }
}
