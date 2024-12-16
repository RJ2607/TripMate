import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/auth%20controllers/loginController.dart';
import 'package:tripmate/controller/navigationController.dart';
import 'package:tripmate/models/tripModel.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/views/Home/headerWidget.dart';

import '../My Trip/trips view/widget/tripCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController loginController = Get.put(LoginController());
  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<TripModel> recentTrips = [];

  NavigationController navigationController = Get.put(NavigationController());

  @override
  void initState() {
    super.initState();
    // Listen to group trips stream
    firestoreFunc.getGroupTripsStream().listen((QuerySnapshot snapshot) {
      final groupTrips = snapshot.docs
          .map((DocumentSnapshot document) =>
              TripModel.fromJson(document.data() as Map<String, dynamic>))
          .where((trip) =>
              trip.createdBy == currentUserId ||
              (trip.invitees != null && trip.invitees!.contains(currentUserId)))
          .toList();
      updateRecentTrips(groupTrips);
    });

    firestoreFunc.getIndividualTripsStream().listen((QuerySnapshot snapshot) {
      final individualTrips = snapshot.docs
          .map((DocumentSnapshot document) =>
              TripModel.fromJson(document.data() as Map<String, dynamic>))
          .where((trip) => trip.createdBy == currentUserId)
          .toList();
      updateRecentTrips(individualTrips);
    });
  }

  void updateRecentTrips(List<TripModel> newTrips) {
    setState(() {
      recentTrips.addAll(newTrips);
      // Sort trips by start date (ascending), then by createdBy
      recentTrips.sort((a, b) {
        if (a.startDate.isBefore(b.startDate)) {
          return -1;
        } else if (a.startDate.isAfter(b.startDate)) {
          return 1;
        } else {
          return a.createdBy.compareTo(b.createdBy);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableHome(
        stretchTriggerOffset: 100,
        appBarColor: Theme.of(context).colorScheme.primaryContainer,
        alwaysShowTitle: true,
        centerTitle: true,
        alwaysShowLeadingAndAction: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          child: Icon(
            MingCute.bell_ringing_line,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () {
            // show notification
          },
          //add on hover whene implementing notification
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              MingCute.currency_rupee_line,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
            style: Theme.of(context).iconButtonTheme.style,
          ),
        ],
        title: Text(
          'Home',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        headerWidget: const HeaderWidget(),
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Trips',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () {
                          // navigate to mytrips using navigation controller
                          navigationController.changePage(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 5,
                            bottom: 5,
                            left: 5,
                          ),
                          child: Text('View All >',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  recentTrips.isEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              width: 3,
                              color: Colors.grey[700]!,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'It seems you have no trips\nStart your journey by clicking the + button below',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          )),
                        )
                      : CarouselSlider.builder(
                          itemCount:
                              recentTrips.length < 5 ? recentTrips.length : 5,
                          itemBuilder: (context, index, realIndex) => TripCard(
                            createdBy: recentTrips[index].createdBy,
                            tripID: recentTrips[index].id,
                            destination: recentTrips[index].destination,
                            startDate: recentTrips[index].startDate,
                            endDate: recentTrips[index].endDate,
                            showType: false,
                            onClick: false,
                          ),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.21,
                            enlargeFactor: 0.3,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayCurve: Curves.easeOutSine,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
