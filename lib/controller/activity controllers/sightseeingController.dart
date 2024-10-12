import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/addActivity.dart';

import '../../constant/firestoreFunc.dart';
import '../../models/activities Model/sightseeingModel.dart';
import '../dateRangeController.dart';
import '../tripsController.dart';

class SightseeingController extends GetxController {
  Rx<SightseeingModel> sightseeingModel = SightseeingModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  Rx<TextEditingController> placeNameController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateSighseeing(
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
    if (placeNameController.value.text.isEmpty) {
      Get.snackbar('Place Name', 'Please enter a place name');
      return;
    }
    if (locationController.value.text.isEmpty) {
      Get.snackbar('Location', 'Please enter a location');
      return;
    }
    if (dateRangeController.selectedStartTimeRange.value == null) {
      Get.snackbar('Departure Time', 'Please select a departure time');
      return;
    }
    if (dateRangeController.selectedEndTimeRange.value == null) {
      Get.snackbar('Arrival Time', 'Please select an arrival time');
      return;
    }

    sightseeingModel.update((sighseeing) {
      sighseeing?.activityName =
          addActivityController.activityNameController.value.text;
      sighseeing?.note = addActivityController.noteController.value.text;
      sighseeing?.placeName = placeNameController.value.text;
      sighseeing?.location = locationController.value.text;

      sighseeing?.departureTime =
          dateRangeController.selectedStartTimeRange.value.toString();
      sighseeing?.arrivalTime =
          dateRangeController.selectedEndTimeRange.value.toString();
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, dayId, category,
        isGroupTrip, sightseeingModel.value.toJson());

    addActivityController.activityNameController.value.clear();
    addActivityController.noteController.value.clear();
    placeNameController.value.clear();
    locationController.value.clear();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
