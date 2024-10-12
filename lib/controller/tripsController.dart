import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/controller/userData.dart';

import 'dateRangeController.dart';

class TripsController extends GetxController {
  Rx<String> tripId = ''.obs;
  Rx<String> dayId = ''.obs;
  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  final DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController inviteController = TextEditingController();

  final RxList<Map<String, dynamic>> invitedFriends =
      <Map<String, dynamic>>[].obs;
  final UserData user = Get.find();
  final Rx<bool> isGroupTrip = false.obs;

  updateTrips() {
    var trip = {
      'destination': destinationController.text,
      'startDate': dateRangeController.selectedDateRange.value!.start,
      'endDate': dateRangeController.selectedDateRange.value!.end,
      'isGroupTrip': isGroupTrip.value,
    };

    if (isGroupTrip.value) {
      trip['invitedFriends'] = invitedFriends.map((e) => e['uid']).toList();
      firestoreFunc.updateGroupTrip(user.user.value!.uid, trip);
    } else {
      firestoreFunc.updateTrip(user.user.value!.uid, trip);
    }
  }

  addTrip() async {
    try {
      if (dateRangeController.selectedDateRange.value == null) {
        Get.snackbar('Date Range', 'Please select a date range');
        return;
      }

      if (destinationController.text.isEmpty) {
        Get.snackbar('Destination', 'Please enter a destination');
        return;
      }

      if (isGroupTrip.value) {
        if (invitedFriends.isEmpty) {
          Get.snackbar('Invite Friends', 'Please invite friends');
          return;
        }
      }

      var trip = {
        'destination': destinationController.text,
        'startDate': dateRangeController.selectedDateRange.value!.start,
        'endDate': dateRangeController.selectedDateRange.value!.end,
        'isGroupTrip': isGroupTrip.value,
      };

      if (isGroupTrip.value) {
        trip['invitedFriends'] = invitedFriends.map((e) => e['uid']).toList();
        destinationController.clear();
        dateRangeController.selectedDateRange.value = null;
        invitedFriends.clear();
        isGroupTrip.value = false;
        firestoreFunc.addGroupTrip(trip, user.user.value!.uid);
      } else {
        destinationController.clear();
        dateRangeController.selectedDateRange.value = null;
        isGroupTrip.value = false;
        firestoreFunc.addIndividualTrip(user.user.value!.uid, trip);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getTrip(String uid) {
    return firestoreFunc.trips(uid).snapshots();
  }
}
