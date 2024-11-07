import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/constant/widgets/dateRangeField.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';

import '../../../controller/auth controllers/userData.dart';

class AddTrips extends StatefulWidget {
  AddTrips({super.key});

  @override
  State<AddTrips> createState() => _AddTripsState();
}

class _AddTripsState extends State<AddTrips> {
  TripsController tripsController = Get.put(TripsController());

  final UserData user = Get.find();

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  String groupID = '';

  void inviteUser(String email) async {
    try {
      var friends = await firestoreFunc.getUserByEmail(email);

      if (user.user.value!.uid == friends!['uid']) {
        log("You can't invite yourself");
        Get.snackbar('Wrong Invite', "You can't invite yourself");
        return;
      }

      for (var i = 0; i < tripsController.invitedFriends.length; i++) {
        if (tripsController.invitedFriends[i]['uid'] == friends['uid']) {
          log("User already invited");
          Get.snackbar('Wrong Invite', "User already invited");
          return;
        }
      }

      tripsController.invitedFriends.add(friends);
    } catch (e) {
      log(e.toString());
      Get.snackbar('Unknown Invite', "User not found");
    }
  }

  void clearInviteUser() {
    tripsController.invitedFriends.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (tripsController.isLoading.value) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(Bootstrap.arrow_left),
                  onTap: () {
                    tripsController
                        .dateRangeController.selectedDateRange.value = null;
                    tripsController.destinationController.clear();
                    tripsController.inviteController.clear();
                    tripsController.invitedFriends.clear();
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
                  controller: tripsController.destinationController,
                  decoration: InputDecoration(
                    labelText: "Where To?!",
                    hintStyle: const TextStyle(
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
                    Checkbox(
                      value: tripsController.isGroupTrip.value,
                      onChanged: (value) {
                        tripsController.isGroupTrip.value = value!;
                      },
                    ),
                    Text(
                      "Group trip",
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                  ],
                ),
                if (tripsController.isGroupTrip.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                          child: TextFormField(
                        textInputAction: TextInputAction.search,
                        controller: tripsController.inviteController,
                        decoration: InputDecoration(
                          labelText: "Invite friends",
                          hintStyle: const TextStyle(
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
                          inviteUser(
                              tripsController.inviteController.text.trim());
                          tripsController.inviteController.clear();
                        },
                        child: const Row(
                          children: [
                            Icon(Bootstrap.plus),
                            Text("Add friends"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Invited users"),
                          TextButton(
                            onPressed: clearInviteUser,
                            child: const Text("Clear"),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                tripsController.invitedFriends.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                tripsController
                                                        .invitedFriends[index]
                                                    ['profile']),
                                          ),
                                          Text(
                                            tripsController
                                                .invitedFriends[index]['name']
                                                .toString()
                                                .split(' ')
                                                .first,
                                          ),
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
                    onPressed: () {
                      tripsController.addTrip();
                      // log(invitedFriends[0].toString());
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Start Planning"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
