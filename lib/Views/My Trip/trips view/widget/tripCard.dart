import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripmate/constant/firestoreFunc.dart';

import '../../activity/daySelect.dart';

class TripCard extends StatelessWidget {
  TripCard({
    Key? key,
    required this.tripID,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.isGroupTrip,
    this.invitedFriends,
  }) : super(key: key);

  String tripID;
  String destination;
  DateTime startDate;
  DateTime endDate;
  bool isGroupTrip;
  List<dynamic>? invitedFriends;

  FirestoreFunc fire = Get.put(FirestoreFunc());

  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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
        Get.to(() => DaySelect(
              tripID: tripID,
              isGroupTrip: isGroupTrip,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 167, 165, 165),
                Color.fromARGB(255, 82, 81, 81),
                // Colors.white
              ]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destination.capitalizeFirst!,
                style: TextStyle(
                  fontSize: MediaQuery.textScalerOf(context).scale(25),
                ),
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
                  Icon(FontAwesome.road_solid),
                  Text(endDay,
                      style: TextStyle(
                        fontSize: MediaQuery.textScalerOf(context).scale(20),
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isGroupTrip ? 'Group Trip' : 'Individual Trip',
                    style: TextStyle(
                      fontSize: MediaQuery.textScalerOf(context).scale(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  isGroupTrip
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.05, // Set a fixed height for the ListView
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                      future: fire.getuserByUid(
                                          invitedFriends![index].toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Shimmer(
                                              child: Align(
                                                widthFactor: 0.5,
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
                                                ),
                                              ),
                                              gradient: LinearGradient(colors: [
                                                const Color.fromARGB(
                                                    255, 53, 53, 53),
                                                Colors.white,
                                                const Color.fromARGB(
                                                    255, 53, 53, 53)
                                              ]));
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
                      : SizedBox(width: 0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
