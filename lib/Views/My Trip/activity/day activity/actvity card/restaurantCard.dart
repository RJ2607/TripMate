import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_corner/smooth_corner.dart';

class RestaurantCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;
  int index;
  RestaurantCard(
    this.data,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    TimeOfDay reservationTime = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(
                data[index]['reservationTime'].millisecondsSinceEpoch)
            .hour,
        minute: DateTime.fromMillisecondsSinceEpoch(
                data[index]['reservationTime'].millisecondsSinceEpoch)
            .minute);
    return SmoothContainer(
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
          Text(
            data[index]['accommodationName'].toString().capitalize!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
          ),
          Text(
            '${reservationTime.format(context)}',
            style: TextStyle(fontSize: 20),
          ),
          Text('Reservation Time}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey)),
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
