import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_corner/smooth_corner.dart';

class LodgingCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;
  int index;
  LodgingCard(
    this.data,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
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
          Text(
            data[index]['accommodationName'].toString().capitalize!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              data[index]['isCheckOut']
                  ? Text(
                      TimeOfDay(
                              hour: DateTime.fromMillisecondsSinceEpoch(
                                      data[index]['checkOutTime']
                                          .millisecondsSinceEpoch)
                                  .hour,
                              minute: DateTime.fromMillisecondsSinceEpoch(
                                      data[index]['checkOutTime']
                                          .millisecondsSinceEpoch)
                                  .minute)
                          .format(context),
                      style: TextStyle(fontSize: 20),
                    )
                  : Text(
                      TimeOfDay(
                              hour: DateTime.fromMillisecondsSinceEpoch(
                                      data[index]['checkInTime']
                                          .millisecondsSinceEpoch)
                                  .hour,
                              minute: DateTime.fromMillisecondsSinceEpoch(
                                      data[index]['checkInTime']
                                          .millisecondsSinceEpoch)
                                  .minute)
                          .format(context),
                      style: TextStyle(fontSize: 20),
                    ),
            ],
          ),
          data[index]['isCheckOut']
              ? const Text(
                  'Check Out Time',
                  style: TextStyle(
                      fontSize: 14,
                      color: ThemeMode.system == ThemeMode.dark
                          ? Colors.grey
                          : Color.fromARGB(255, 54, 54, 54)),
                )
              : const Text(
                  'Check In Time',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
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
