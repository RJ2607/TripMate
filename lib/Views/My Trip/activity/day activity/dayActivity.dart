import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/tripsController.dart';

import '../addActivity.dart';

class DayActivity extends StatelessWidget {
  String weekDay;
  int dayNumber;
  bool isGroupTrip;
  TripsController tripsController = Get.put(TripsController());
  AddActivityController addActivityController =
      Get.put(AddActivityController());

  DayActivity({
    super.key,
    required this.weekDay,
    required this.dayNumber,
    required this.isGroupTrip,
  });

  //dummy data for chips
  List<String> categories = [
    'Food',
    'Transport',
    'Accomodation',
    'Activity',
    'Miscellaneous',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Day $dayNumber',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Wrap(
                spacing: 10,
                children: [
                  ...List.generate(categories.length + 1, (index) {
                    if (index == categories.length) {
                      return GestureDetector(
                        onTap: () => Get.to(() => AddActivity(
                              isGroupTrip: isGroupTrip,
                            )),
                        child: Chip(
                          label: const Icon(Icons.add),
                          padding: const EdgeInsets.all(8),
                          shape: const CircleBorder(),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        log(addActivityController.activityDate.value
                            .toString());
                      },
                      child: Chip(
                        label: Text(categories[index]),
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
