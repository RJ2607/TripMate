import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:tripmate/utils/responsive.dart';
import 'package:tripmate/views/My%20Trip/trips%20view/widget/tripCard.dart';

import '../../../utils/firestoreFunc.dart';

class IndividualTrip extends StatefulWidget {
  IndividualTrip({super.key});

  @override
  State<IndividualTrip> createState() => _IndividualTripState();
}

class _IndividualTripState extends State<IndividualTrip> {
  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreFunc.getIndividualTripsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondaryContainer,
                          const Color.fromARGB(255, 25, 25, 25),
                          Theme.of(context).colorScheme.secondaryContainer,
                        ],
                      ),
                      child: SmoothContainer(
                        height: MediaQuery.of(context).size.height * 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        smoothness: 0.6,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ));
                }
                var data = snapshot.data!.docs;

                if (data.isEmpty) {
                  return const Center(
                    child: Text('No trips yet'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    // log(firestoreFunc.user!.uid);
                    if (data[index]['createdBy'] ==
                        FirebaseAuth.instance.currentUser!.uid) {
                      DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
                          data[index]['startDate'].millisecondsSinceEpoch);
                      DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
                          data[index]['endDate'].millisecondsSinceEpoch);
                      // log(data[index].id);

                      return SizedBox(
                        height: 173.sH(context),
                        width: MediaQuery.of(context).size.width,
                        child: TripCard(
                          createdBy: data[index]['createdBy'],
                          tripID: data[index].id,
                          destination: data[index]['destination'].toString(),
                          startDate: startDate,
                          endDate: endDate,
                          onClick: true,
                          invitedFriends: [],
                          isGroupTrip: data[index]['isGroupTrip'],
                        ),
                      );
                    }
                    if (data[index]['isGroupTrip'] == true) {
                      return const SizedBox.shrink();
                    }
                    if (data[index]['createdBy'] != firestoreFunc.user!.uid) {
                      return const SizedBox.shrink();
                    }
                    return null;
                  },
                );
              }),
        ),
      ],
    );
  }
}
