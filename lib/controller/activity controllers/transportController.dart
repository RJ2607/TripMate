import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/firestoreFunc.dart';
import 'package:tripmate/controller/dateRangeController.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';
import 'package:tripmate/models/Activities%20Model/transportModel.dart';
import 'package:tripmate/views/My%20Trip/activity/addActivity.dart';

class TransportController extends GetxController {
  Rx<TransportModel> transportModel = TransportModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  Rx<TextEditingController> travelModeController = TextEditingController().obs;
  Rx<TextEditingController> departureLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> arrivalLocationController =
      TextEditingController().obs;

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateTransport(
    bool isGroupTrip,
    String category,
    DateTime date,
  ) {
    if (addActivityController.activityNameController.value.text.isEmpty) {
      Get.snackbar('Activity Name', 'Please enter an activity name');
      return;
    }
    if (addActivityController.noteController.value.text.isEmpty) {
      Get.snackbar('Note', 'Please enter a note');
      return;
    }
    if (travelModeController.value.text.isEmpty) {
      Get.snackbar('Travel Mode', 'Please enter a travel mode');
      return;
    }
    if (departureLocationController.value.text.isEmpty) {
      Get.snackbar('Departure Location', 'Please enter a departure location');
      return;
    }
    if (arrivalLocationController.value.text.isEmpty) {
      Get.snackbar('Arrival Location', 'Please enter an arrival location');
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
    transportModel.update((transport) {
      DateTime _departureTime = DateTime(
        date.year,
        date.month,
        date.day,
        dateRangeController.selectedStartTimeRange.value!.hour,
        dateRangeController.selectedStartTimeRange.value!.minute,
      );
      DateTime _arrivalTime = DateTime(
        date.year,
        date.month,
        date.day,
        dateRangeController.selectedEndTimeRange.value!.hour,
        dateRangeController.selectedEndTimeRange.value!.minute,
      );
      transport?.activityName =
          addActivityController.activityNameController.value.text;
      transport?.note = addActivityController.noteController.value.text;
      transport?.travelMode = travelModeController.value.text;
      transport?.departureLocation = departureLocationController.value.text;
      transport?.arrivalLocation = arrivalLocationController.value.text;
      transport?.departureTime =
          _departureTime;
      transport?.arrivalTime =
          _arrivalTime;
      transport?.date = date;
      transport?.category = category;
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, isGroupTrip,
        transportModel.value.toJson());

    addActivityController.activityNameController.value.clear();
    addActivityController.noteController.value.clear();
    travelModeController.value.clear();
    departureLocationController.value.clear();
    arrivalLocationController.value.clear();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
