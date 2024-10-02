import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/constant/widgets/dateRangeField.dart';

import '../../../controller/dateRangeController.dart';
import '../../../controller/userData.dart';
import '../activity/daySelect.dart';

class AddTrips extends StatelessWidget {
  AddTrips({super.key});

  final DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController inviteController = TextEditingController();
  final FirestoreFunc firestoreFunc = FirestoreFunc();
  final RxList<Map<String, dynamic>> invitedFriends =
      <Map<String, dynamic>>[].obs;
  final UserData user = Get.find();
  final Rx<bool> isGroupTrip = false.obs;

  void inviteUser(String email) async {
    try {
      var friends = await FirestoreFunc.getUserByEmail(email);
      if (user.user.value!.uid == friends!['uid']) {
        log("You can't invite yourself");
        Get.snackbar('Wrong Invite', "You can't invite yourself");
        return;
      }

      for (var i = 0; i < invitedFriends.length; i++) {
        if (invitedFriends[i]['uid'] == friends['uid']) {
          log("User already invited");
          Get.snackbar('Wrong Invite', "User already invited");
          return;
        }
      }

      invitedFriends.add(friends);
      log(invitedFriends[0]['uid']);
        } catch (e) {
      log(e.toString());
    }
  }

  void clearInviteUser() {
    invitedFriends.clear();
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
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(Bootstrap.arrow_left),
                  onTap: () {
                    dateRangeController.selectedDateRange.value = null;
                    destinationController.clear();
                    inviteController.clear();
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
                const DateRangePickerWidget(),
                Row(
                  children: [
                    Checkbox(
                      value: isGroupTrip.value,
                      onChanged: (value) {
                        isGroupTrip.value = value!;
                      },
                    ),
                    Text(
                      "Group trip",
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                  ],
                ),
                if (isGroupTrip.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                          child: TextFormField(
                        textInputAction: TextInputAction.search,
                        controller: inviteController,
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
                          inviteUser(inviteController.text);
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
                                invitedFriends.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                invitedFriends[index]
                                                    ['profile']),
                                          ),
                                          Text(
                                            invitedFriends[index]['name']
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
                      Get.to(() => DaySelect(
                            startDate: dateRangeController
                                .selectedDateRange.value!.start,
                            endDate: dateRangeController
                                .selectedDateRange.value!.end,
                            totalDays: dateRangeController
                                .selectedDateRange.value!.end
                                .difference(dateRangeController
                                    .selectedDateRange.value!.start)
                                .inDays,
                            startWeekDay: dateRangeController
                                .selectedDateRange.value!.start.weekday,
                          ));
                      log((7 % 7).toString());
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
