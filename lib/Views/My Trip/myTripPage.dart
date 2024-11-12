import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/views/My%20Trip/trips%20view/individualTrip.dart';

import 'trips view/groupTrip.dart';

class MyTab extends GetxController {
  late TabController controller;

  final List<Tab> tabs = [
    const Tab(text: 'Individual Trip'),
    const Tab(text: 'Group Trip'),
  ];

  void initController(TickerProvider vsync) {
    controller = TabController(length: tabs.length, vsync: vsync);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class MyTrip extends StatefulWidget {
  const MyTrip({super.key});

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> with SingleTickerProviderStateMixin {
  MyTab myTab = Get.put(MyTab());

  @override
  void initState() {
    super.initState();
    myTab = Get.put(MyTab());
    myTab.initController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(
          labelColor: Theme.of(context).colorScheme.primaryContainer,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          controller: myTab.controller,
          tabs: myTab.tabs,
        ),
        title: const Text(
          'My Trips',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TabBarView(
            physics: const ScrollPhysics(),
            controller: myTab.controller,
            children: [
              IndividualTrip(),
              GroupTrip(),
            ],
          )),
    );
  }
}
