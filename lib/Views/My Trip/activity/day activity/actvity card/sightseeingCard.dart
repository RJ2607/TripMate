import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SightseeingCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;
  int index;
  SightseeingCard(
    this.data,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    TimeOfDay arrivalTime = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(
                data[index]['arrivalTime'].millisecondsSinceEpoch)
            .hour,
        minute: DateTime.fromMillisecondsSinceEpoch(
                data[index]['arrivalTime'].millisecondsSinceEpoch)
            .minute);
    TimeOfDay departureTime = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(
                data[index]['departureTime'].millisecondsSinceEpoch)
            .hour,
        minute: DateTime.fromMillisecondsSinceEpoch(
                data[index]['departureTime'].millisecondsSinceEpoch)
            .minute);

    var totalHours = departureTime.hour - arrivalTime.hour;
    return SmoothContainer(
      margin: const EdgeInsets.only(bottom: 15),
      smoothness: 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      borderRadius: BorderRadius.circular(25),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmoothContainer(
            smoothness: 0.6,
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage('https://placehold.co/600x400/png', scale: 1),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Text(
            data[index]['activityName'].toString().capitalize!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Text(
                arrivalTime.format(context),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              const Icon(
                Iconsax.arrow_right_1_outline,
                size: 18,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                departureTime.format(context),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Text('Total Time: ${totalHours} hours',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          Divider(),
          Text(
            data[index]['note'].toString().capitalize!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
