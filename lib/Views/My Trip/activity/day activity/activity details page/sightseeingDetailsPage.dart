import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../../../utils/flutterBasicsTools.dart';

class SightseeingDetailsPage extends StatelessWidget {
  SightseeingDetailsPage({super.key});

  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot<Object?> data = Get.arguments['data'];
    TimeOfDay arrivalTime = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(
                data['arrivalTime'].millisecondsSinceEpoch)
            .hour,
        minute: DateTime.fromMillisecondsSinceEpoch(
                data['arrivalTime'].millisecondsSinceEpoch)
            .minute);
    TimeOfDay departureTime = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(
                data['departureTime'].millisecondsSinceEpoch)
            .hour,
        minute: DateTime.fromMillisecondsSinceEpoch(
                data['departureTime'].millisecondsSinceEpoch)
            .minute);

    var totalMinutes = departureTime.minute - arrivalTime.minute;
    var totalHours = totalMinutes / 60;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.003,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['activityName'].toString().capitalize!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          data['note'].toString().capitalize!,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['placeDetailsModel']['name']
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
                    Text(
                        '${totalHours.toInt()} hrs ${totalMinutes.toInt()} mins',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                FutureBuilder(
                    future: flutterBasicsTools
                        .imageLoader(data['placeDetailsModel']['photoRef']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                Colors.black,
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ],
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location',
                        style: Theme.of(context).textTheme.headlineMedium),
                    GestureDetector(
                      onTap: () => Get.toNamed('/maps',
                          arguments: {'data': data['placeDetailsModel']}),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Icon(
                          Iconsax.location_bold,
                          size: MediaQuery.of(context).size.width * 0.055,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: SmoothClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    smoothness: 0.6,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(data['placeDetailsModel']['lat'],
                            data['placeDetailsModel']['lng']),
                        zoom: 15,
                      ),
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      markers: {
                        Marker(
                          markerId: MarkerId('departureLocation'),
                          position: LatLng(data['placeDetailsModel']['lat'],
                              data['placeDetailsModel']['lng']),
                        ),
                      },
                    ),
                  ),
                ),
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
                        data['placeDetailsModel']['address']
                            .toString()
                            .capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('Rating',
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              child: CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                                strokeWidth: 5,
                                value: data['placeDetailsModel']['rating'] / 5,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  data['placeDetailsModel']['rating']
                                      .toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Reviews',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                              data['placeDetailsModel']['userRatingCount']
                                  .toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
