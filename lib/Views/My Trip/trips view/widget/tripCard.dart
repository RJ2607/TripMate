import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';
import 'package:tripmate/utils/firestoreFunc.dart';

import '../../activity/day activity/daySelect.dart';

class TripCard extends StatelessWidget {
  TripCard({
    super.key,
    required this.createdBy,
    required this.tripID,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.isGroupTrip,
    this.invitedFriends,
    required this.showType,
    required this.onClick,
  });

  String createdBy;
  String tripID;
  String destination;
  DateTime startDate;
  DateTime endDate;
  bool? isGroupTrip;
  List<dynamic>? invitedFriends;
  bool showType;
  bool onClick;

  FirestoreFunc fire = Get.put(FirestoreFunc());

  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  TripsController tripsController = Get.put(TripsController());

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    String startDay =
        '${startDate.day}, ${days[startDate.weekday - 1]} ${startDate.year}';
    String endDay =
        '${endDate.day}, ${days[endDate.weekday - 1]} ${endDate.year}';

    return GestureDetector(
      onTap: () {
        if (onClick) {
          Get.to(() => DaySelect(
                isGroupTrip: isGroupTrip!,
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 167, 165, 165),
                Color.fromARGB(255, 82, 81, 81),
                // Colors.white
              ]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    destination.capitalizeFirst!,
                    style: TextStyle(
                      fontSize: MediaQuery.textScalerOf(context).scale(25),
                    ),
                  ),
                  InkWell(
                    onTap: () => showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Trip Delete'),
                            content: const Text(
                                'Are you sure you want to delete trip?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  tripsController.deleteTrip(
                                      isGroupTrip!, tripID);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }),
                    child: Icon(Icons.delete),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(startDay,
                      style: TextStyle(
                        fontSize: MediaQuery.textScalerOf(context).scale(20),
                        fontWeight: FontWeight.w500,
                      )),
                  const Icon(FontAwesome.road_solid),
                  Text(endDay,
                      style: TextStyle(
                        fontSize: MediaQuery.textScalerOf(context).scale(20),
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Created by: ',
                      style: TextStyle(
                        fontSize: MediaQuery.textScalerOf(context).scale(16),
                        fontWeight: FontWeight.w400,
                      )),
                  FutureBuilder(
                      future: fire.getUserByUid(createdBy),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer(
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 0, 0, 0),
                                Colors.white,
                                Color.fromARGB(255, 0, 0, 0)
                              ]),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius:
                                    MediaQuery.of(context).size.width * 0.043,
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.041,
                                ),
                              ));
                        }
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.043,
                          backgroundImage:
                              NetworkImage(snapshot.data['profile']),
                        );
                      }),
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              if (showType)
                Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              if (showType)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isGroupTrip! ? 'Group Trip' : 'Individual Trip',
                      style: TextStyle(
                        fontSize: MediaQuery.textScalerOf(context).scale(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    isGroupTrip!
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.05, // Set a fixed height for the ListView
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                        future: fire.getUserByUid(
                                            invitedFriends![index].toString()),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Colors.white,
                                                      Color.fromARGB(
                                                          255, 0, 0, 0)
                                                    ]),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.043,
                                                  child: CircleAvatar(
                                                    radius:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.041,
                                                  ),
                                                ));
                                          }
                                          return Align(
                                            widthFactor: 0.5,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.043,
                                              child: CircleAvatar(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.041,
                                                backgroundImage: NetworkImage(
                                                    snapshot.data['profile']),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  itemCount: invitedFriends!.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(width: 0),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
