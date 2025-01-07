import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/auth%20controllers/loginController.dart';
import 'package:tripmate/controller/navigationController.dart';
import 'package:tripmate/models/tripModel.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/utils/responsive.dart';

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
  TextEditingController searchController = TextEditingController();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        headerWidget(context),
        SizedBox(
          height: 20.sH(context),
        ),
        SearchField(searchController: searchController),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sW(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Trips',
                style: TextStyle(
                  fontSize: 20.sW(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  navigationController.changePage(1);
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16.sW(context),
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        recentTrips.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 173.sH(context),
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  )),
                ),
              )
            : SizedBox(
                height: 173.sH(context),
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  itemCount: recentTrips.length,
                  pageSnapping: false,
                  physics: BouncingScrollPhysics(),
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.88),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            right: index != (recentTrips.length - 1)
                                ? 16.sW(context)
                                : 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              width: 3,
                              color: Colors.grey[700]!,
                            ),
                          ),
                        ));
                  },
                ),
              ),
      ],
    );
  }

  Padding headerWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sW(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 24.sW(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Welcome to Trip Mat',
                style: TextStyle(
                  fontSize: 16.sW(context),
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/home/profile');
            },
            child: Container(
              height: 40.sH(context),
              width: 40.sW(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      loginController.user.user.value!.photoURL.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sW(context)),
        child: SizedBox(
          height: 48.sH(context),
          child: TextField(
            cursorColor: Theme.of(context).hintColor,
            controller: searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hoverColor: Colors.transparent,
              filled: true,
              fillColor: Theme.of(context).hintColor.withOpacity(0.1),
              labelText: 'Search',
              labelStyle: TextStyle(
                fontSize: 16.sW(context),
                color: Theme.of(context).hintColor,
              ),
              prefixIcon: Icon(
                Iconsax.search_normal_1_outline,
                size: 20.sW(context),
                color: Theme.of(context).hintColor,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
  }
}
