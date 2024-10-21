import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/controller/userData.dart';

import 'widget/tripCard.dart';

class GroupTrip extends StatelessWidget {
  GroupTrip({super.key});

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  UserData user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreFunc.getGroupTripsStream(),
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
                    if (data[index]['createdBy'] != user.user.value!.uid) {
                      return const SizedBox.shrink();
                    }
                    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
                        data[index]['startDate'].millisecondsSinceEpoch);
                    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
                        data[index]['endDate'].millisecondsSinceEpoch);

                    return TripCard(
                      tripID: data[index].id,
                      destination: data[index]['destination'].toString(),
                      startDate: startDate,
                      endDate: endDate,
                      isGroupTrip: data[index]['isGroupTrip'],
                      invitedFriends: data[index]['invitedFriends'],
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
