import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TransportCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;
  int index;
  TransportCard(
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

    var totalHours = arrivalTime.hour - departureTime.hour;

    log(data[1]['departureLocation']['rating'].toString());

    return GestureDetector(
      onTap: () => Get.toNamed(
        '/mytrip/daySelect/dayActivity/transport',
        arguments: {
          'data': data[index],
        },
      ),
      child: SmoothContainer(
        margin: const EdgeInsets.only(bottom: 15),
        smoothness: 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index]['departureLocation']['name']
                          .toString()
                          .capitalize!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      departureTime.format(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Icon(
                  Iconsax.arrow_right_1_outline,
                  size: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index]['arrivalLocation']['name']
                          .toString()
                          .capitalize!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      arrivalTime.format(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            Text('Total Time: ${totalHours} hours',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(data[index]['travelMode'].toString().capitalize!,
                style: Theme.of(context).textTheme.bodyLarge!),
            Text(
              data[index]['activityName'].toString().capitalize!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.location_bold,
                  size: MediaQuery.of(context).size.width * 0.055,
                  color: Colors.red,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Expanded(
                  child: Text(
                    data[index]['departureLocation']['address']
                        .toString()
                        .capitalize!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
                ),
                // Icon(
                //   Iconsax.arrow_right_1_outline,
                //   color: Colors.grey,
                //   size: MediaQuery.of(context).size.width * 0.055,
                // ),
                Expanded(
                    child: Text(
                  data[index]['arrivalLocation']['address']
                      .toString()
                      .capitalize!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
