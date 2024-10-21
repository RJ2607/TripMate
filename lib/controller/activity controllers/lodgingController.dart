import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/dateRangeController.dart';
import 'package:tripmate/models/Activities%20Model/lodgingModel.dart';

import '../../constant/firestoreFunc.dart';
import '../../views/My Trip/activity/addActivity.dart';
import '../tripsController.dart';

class LodgingController extends GetxController {
  Rx<LodgingModel> lodgingModel = LodgingModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  Rx<TextEditingController> accommodationController =
      TextEditingController().obs;

  Rx<TextEditingController> locationController = TextEditingController().obs;

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  Rx<bool> isCheckOut = false.obs;

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateLodging(
    bool isGroupTrip,
    String category,
    String dayId,
  ) {
    if (addActivityController.activityNameController.value.text.isEmpty) {
      Get.snackbar('Activity Name', 'Please enter an activity name');
      return;
    }
    if (addActivityController.noteController.value.text.isEmpty) {
      Get.snackbar('Note', 'Please enter a note');
      return;
    }
    if (accommodationController.value.text.isEmpty) {
      Get.snackbar('Accommodation Name', 'Please enter an accommodation name');
      return;
    }
    if (locationController.value.text.isEmpty) {
      Get.snackbar('Location', 'Please enter a location');
      return;
    }
    if (isCheckOut.value) {
      if (dateRangeController.selectedEndTimeRange.value == null) {
        Get.snackbar('Check Out Time', 'Please select a check out time');
        return;
      }
    } else {
      if (dateRangeController.selectedStartTimeRange.value == null) {
        Get.snackbar('Check In Time', 'Please select a check in time');
        return;
      }
    }

    lodgingModel.update((lodging) {
      lodging?.activityName =
          addActivityController.activityNameController.value.text;
      lodging?.note = addActivityController.noteController.value.text;
      lodging?.accommodationName = accommodationController.value.text;

      lodging?.location = locationController.value.text;
      lodging?.isCheckOut = isCheckOut.value;
      isCheckOut.value
          ? lodging?.checkOutTime =
              dateRangeController.selectedEndTimeRange.value.toString()
          : lodging?.checkInTime =
              dateRangeController.selectedStartTimeRange.value.toString();
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, dayId, category,
        isGroupTrip, lodgingModel.value.toJson());

    addActivityController.activityNameController.value.clear();
    addActivityController.noteController.value.clear();
    accommodationController.value.clear();
    locationController.value.clear();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
