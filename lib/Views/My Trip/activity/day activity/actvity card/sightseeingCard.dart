import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:tripmate/utils/flutterBasicsTools.dart';

class SightseeingCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;

  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();
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

    var totalHours = arrivalTime.hour - departureTime.hour;
    return SmoothContainer(
      margin: const EdgeInsets.only(bottom: 15),
      smoothness: 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      borderRadius: BorderRadius.circular(25),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data[index]['placeDetailsModel']['name'].toString().capitalize!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            data[index]['activityName'].toString().capitalize!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          FutureBuilder(
              future: flutterBasicsTools
                  .imageLoader(data[index]['placeDetailsModel']['photoRef']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondaryContainer,
                          Colors.black,
                          Theme.of(context).colorScheme.secondaryContainer,
                        ],
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ));
                }
                return SmoothClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    smoothness: 0.6,
                    child: Image.memory(snapshot.data!));
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Text(
                departureTime.format(context),
                style: TextStyle(
                  fontSize: 20,
                ),
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
                arrivalTime.format(context),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text('Total Time: ${totalHours} hours',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          Divider(),
          Row(
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
                  data[index]['placeDetailsModel']['address']
                      .toString()
                      .capitalize!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
