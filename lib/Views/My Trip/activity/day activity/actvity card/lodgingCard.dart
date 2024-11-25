import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:tripmate/utils/flutterBasicsTools.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/activity%20details%20page/lodgingDetailsPage.dart';

class LodgingCard extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> data;

  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();
  int index;
  LodgingCard(
    this.data,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => LodgingDetailsPage(
            data[index],
          )),
      child: SmoothContainer(
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
      ),
    );
  }
}
