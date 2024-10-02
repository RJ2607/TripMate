import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class MyTrip extends StatefulWidget {
  const MyTrip({super.key});

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        extendedIconLabelSpacing: 0,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        tooltip: 'Add Trips',
        label: const Text('Add Trips'),
        onPressed: () {
          Navigator.pushNamed(context, '/addTrips');
        },
        icon: const Icon(Bootstrap.plus),
      ),
    );
  }
}
