import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/constant/widgets/dateRangeField.dart';

import '../../controller/dateRangeController.dart';
import '../../controller/userData.dart';

class AddTrips extends StatefulWidget {
  const AddTrips({super.key});

  @override
  State<AddTrips> createState() => _AddTripsState();
}

class _AddTripsState extends State<AddTrips> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController inviteController = TextEditingController();
  FirestoreFunc firestoreFunc = FirestoreFunc();
  Map<String, dynamic>? friends;
  List<Map<String, dynamic>> invitedFriends = [];
  UserData user = Get.find();

  bool isGroupTrip = false;

  final DateRangePickerController controller =
      Get.put(DateRangePickerController());

  late DateTimeRange selectedDateRange;

  void setSelectedDateRange() {
    selectedDateRange = controller.selectedDateRange.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Bootstrap.arrow_left),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                "Plan a new trip",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Build an itinerary and map out\nyour upcoming travel plans",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Form(
                  child: TextFormField(
                textInputAction: TextInputAction.search,
                controller: destinationController,
                decoration: InputDecoration(
                  // hintText: "Trip name",
                  labelText: "Where To?!",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              DateRangePickerWidget(),
              Row(
                children: [
                  Form(
                      child: Checkbox(
                    value: isGroupTrip,
                    onChanged: (bool? value) {
                      setState(() {
                        isGroupTrip = value!;
                      });
                    },
                  )),
                  Text(
                    "Group trip",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ),
                ],
              ),
              if (isGroupTrip)
                Column(
                  children: [
                    Form(
                        child: TextFormField(
                      textInputAction: TextInputAction.search,
                      controller: inviteController,
                      decoration: InputDecoration(
                        // hintText: "Trip name",
                        labelText: "Invite friends",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    GestureDetector(
                      onTap: () {
                        inviteUser(inviteController.text);
                      },
                      child: Row(
                        children: [
                          Icon(Bootstrap.plus),
                          Text("Add friends"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Invited users"),
                        TextButton(
                          onPressed: () {
                            clearInviteUser();
                          },
                          child: Text("Clear"),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...List.generate(
                              invitedFriends.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              invitedFriends[index]['profile']),
                                        ),
                                        Text(invitedFriends[index]['name']),
                                      ],
                                    ),
                                  )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                  ],
                ),
              Center(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Start Planning"),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void inviteUser(String email) async {
    try {
      friends = await FirestoreFunc.getUserByEmail(email);
      // log(friends!['uid']);
      if (user.user.value!.uid == friends!['uid']) {
        log("You can't invite yourself");
        Get.snackbar('Wrong Invite', "You can't invite yourself");
        return;
      }

      for (var i = 0; i < invitedFriends.length; i++) {
        if (invitedFriends[i]['uid'] == friends!['uid']) {
          log("User already invited");
          Get.snackbar('Wrong Invite', "User already invited");
          return;
        }
      }

      if (friends != null) {
        setState(() {
          invitedFriends.add(friends!);
        });
        // invitedFriends.add(friends!);
        log(invitedFriends[0]['uid']);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void clearInviteUser() {
    setState(() {
      invitedFriends.clear();
    });
    // invitedFriends.clear();
  }
}
