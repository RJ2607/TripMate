import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:tripmate/views/My%20Trip/trips%20view/widget/tripCard.dart';

import '../../../constant/firestoreFunc.dart';

class IndividualTrip extends StatelessWidget {
  IndividualTrip({super.key});

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // padding: EdgeInsets.all(10),

          // height: MediaQuery.of(context).size.height * 0.729,
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreFunc.getIndividualTripsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade300,
                          Colors.grey.shade100,
                          Colors.grey.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: SmoothContainer(
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: const EdgeInsets.symmetric(vertical: 10),
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
                    if (data[index]['isGroupTrip'] == false) {
                      DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
                          data[index]['startDate'].millisecondsSinceEpoch);
                      DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
                          data[index]['endDate'].millisecondsSinceEpoch);
                      // log(data[index].id);

                      return TripCard(
                          tripID: data[index].id,
                          destination: data[index]['destination'].toString(),
                          startDate: startDate,
                          endDate: endDate,
                          isGroupTrip: data[index]['isGroupTrip']);
                    }
                    if (data[index]['isGroupTrip'] == true) {
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
