import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/utils/responsive.dart';

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
    required this.onClick,
  });

  String createdBy;
  String tripID;
  String destination;
  DateTime startDate;
  DateTime endDate;
  bool? isGroupTrip;
  List<dynamic>? invitedFriends = [];
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

    log(isGroupTrip.toString());

    return GestureDetector(
      onTap: () {
        log(isGroupTrip.toString());
        if (onClick) {
          tripsController.tripId.value = tripID;
          tripsController.isGroupTrip.value = isGroupTrip!;
          Get.toNamed('/mytrip/daySelect');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 15.sW(context), vertical: 12.sH(context)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_scenary.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 32.sH(context),
                  width: 96.sW(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.sW(context), vertical: 4.sH(context)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: fire.getUserByUid(createdBy),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 24.sW(context),
                                  height: 24.sW(context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: 24.sW(context),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data['profile']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        width: 8.sW(context),
                      ),
                      Text(
                        'Created',
                        style: TextStyle(
                          fontSize: 16.sW(context),
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                !isGroupTrip!
                    ? SizedBox.shrink()
                    : Container(
                        height: 30.sH(context),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.sW(context), vertical: 2.sH(context)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              List.generate(invitedFriends!.length, (index) {
                            return FutureBuilder(
                                future: fire.getUserByUid(
                                    invitedFriends![index].toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 0, 0, 0),
                                          Colors.white,
                                          Color.fromARGB(255, 0, 0, 0)
                                        ]),
                                        child: Container(
                                          width: 24.sW(context),
                                          height: 24.sW(context),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ));
                                  }
                                  return Align(
                                    widthFactor: 0.8,
                                    child: Container(
                                      width: 24.sW(context),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data['profile']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
              ],
            ),
            Spacer(),
            Container(
              height: 60.sH(context),
              padding: EdgeInsets.symmetric(
                  horizontal: 12.sW(context), vertical: 10.sH(context)),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.capitalizeFirst!,
                    style: TextStyle(
                      fontSize: 20.sW(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        startDay,
                        style: TextStyle(
                          fontSize: 14.sW(context),
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        endDay,
                        style: TextStyle(
                          fontSize: 14.sW(context),
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
