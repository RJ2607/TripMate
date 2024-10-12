import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/tripsController.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/addActivity.dart';

import '../../../constant/firestoreFunc.dart';
import 'dayActivity.dart';

class DaySelect extends StatelessWidget {
  bool isGroupTrip;

  DaySelect({
    super.key,
    required this.isGroupTrip,
  });

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  TripsController tripsController = Get.put(TripsController());
  AddActivityController addActivityController =
      Get.put(AddActivityController());

  Map<int, String> days = {
    0: 'Monday',
    1: 'Tuesday',
    2: 'Wednesday',
    3: 'Thursday',
    4: 'Friday',
    5: 'Saturday',
    6: 'Sunday',
  };

  // Color selectedColor = Colors.blue;
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
                    child: const Icon(Bootstrap.arrow_left),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  const Text(
                    'Dates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Plan every of your selected dates',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FutureBuilder(
                future: isGroupTrip
                    ? firestoreFunc
                        .getGroupTripsById(tripsController.tripId.value)
                    : firestoreFunc
                        .getIndividualTripById(tripsController.tripId.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data;
                  DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
                      data['startDate'].millisecondsSinceEpoch);
                  DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
                      data['endDate'].millisecondsSinceEpoch);
                  int totalDays = endDate.difference(startDate).inDays + 1;
                  int startWeekDay = startDate.weekday - 1;
                  log('Start Date: $startDate');
                  log('End Date: $endDate');
                  log('Total Days: $totalDays');
                  log('Start Week Day: $startWeekDay');
                  return Center(
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      children: List.generate(totalDays, (index) {
                        // log((days[(widget.startWeekDay + index) % 7]).toString());
                        return GestureDetector(
                          onTap: () {
                            addActivityController.activityDate.value =
                                startDate.add(Duration(days: index));
                            log(startDate
                                .add(Duration(days: index))
                                .toString());
                            Get.to(() => DayActivity(
                                  weekDay: days[(startWeekDay + index) % 7]!,
                                  dayNumber: index + 1,
                                  isGroupTrip: isGroupTrip,
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${startDate.day + index}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  days[(startWeekDay + index) % 7]!
                                      .substring(0, 3),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
