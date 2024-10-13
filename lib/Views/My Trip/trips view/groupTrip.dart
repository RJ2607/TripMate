import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:tripmate/constant/firestoreFunc.dart';

import 'widget/tripCard.dart';

class GroupTrip extends StatelessWidget {
  GroupTrip({super.key});

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreFunc.getTripsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.docs;

                if (data.isEmpty) {
                  return const Center(
                    child: Text('No trips yet'),
                  );
                }

                if (data[0]['isGroupTrip'] == false) {
                  return const Center(
                    child: Text('No group trips yet'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    if (data[index]['isGroupTrip'] == false) {
                      return const SizedBox.shrink();
                    }

                    return FutureBuilder(
                      future: firestoreFunc
                          .getGroupTripsById(data[index]['groupId']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer(
                              enabled: true,
                              loop: 10,
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.white,
                                  // Colors.black
                                ],
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                              ),
                              child: SmoothContainer(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                smoothness: 0.6,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                  width: 1,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
                                ),
                              ));
                        }

                        var groupData = snapshot.data!;

                        DateTime startDate =
                            DateTime.fromMillisecondsSinceEpoch(
                                groupData['startDate'].millisecondsSinceEpoch);
                        DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
                            groupData['endDate'].millisecondsSinceEpoch);

                        return TripCard(
                          tripID: data[index]['groupId'],
                          destination: groupData['destination'].toString(),
                          startDate: startDate,
                          endDate: endDate,
                          isGroupTrip: groupData['isGroupTrip'],
                          invitedFriends: groupData['invitedFriends'],
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
