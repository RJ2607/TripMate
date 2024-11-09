import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/dateRangeController.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';
import 'package:tripmate/models/Activities%20Model/transportModel.dart';
import 'package:tripmate/models/google%20cloud%20models/maps/placeModel.dart';
import 'package:tripmate/views/My%20Trip/activity/addActivity.dart';

import '../../utils/firestoreFunc.dart';
import '../../utils/flutterBasicsTools.dart';
import '../google cloud controllers/googleMapContreller.dart';

class TransportController extends GetxController {
  Rx<TransportModel> transportModel = TransportModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());
  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();
  GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  Rx<TextEditingController> travelModeController = TextEditingController().obs;
  Rx<PlaceDetailsModel> departureLocation = PlaceDetailsModel().obs;
  Rx<PlaceDetailsModel> arrivalLocation = PlaceDetailsModel().obs;

  Rx<String> departureLocationId = ''.obs;
  Rx<String> arrivalLocationId = ''.obs;

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateTransport(
    bool isGroupTrip,
    String category,
    DateTime date,
  ) async {
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
    if (departureLocationId.value.isEmpty) {
      Get.snackbar('Departure Location', 'Please select a departure location');
      return;
    }
    if (arrivalLocationId.value.isEmpty) {
      Get.snackbar('Arrival Location', 'Please select an arrival location');
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

    departureLocation.value = await googleCloudMapController.getPlaceDetails(
      departureLocationId.value,
    );
    arrivalLocation.value = await googleCloudMapController.getPlaceDetails(
      arrivalLocationId.value,
    );

    Uint8List? arrivalImage = await googleCloudMapController.getPlacePhoto(
        arrivalLocation.value.photoRef!, 400, 400);
    Uint8List? storedArrivalImage =
        await flutterBasicsTools.readImage(arrivalLocation.value.photoRef!);
    Uint8List? departureImage = await googleCloudMapController.getPlacePhoto(
        departureLocation.value.photoRef!, 400, 400);
    Uint8List? storedDepartureImage =
        await flutterBasicsTools.readImage(departureLocation.value.photoRef!);
    try {
      if (storedArrivalImage == null)
        await flutterBasicsTools.storeImage(
            arrivalImage!, arrivalLocation.value.photoRef!);
      if (storedDepartureImage == null)
        await flutterBasicsTools.storeImage(
            departureImage!, departureLocation.value.photoRef!);
    } catch (e) {
      log(e.toString());
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
      transport?.departureLocation = departureLocation.value;
      transport?.arrivalLocation = arrivalLocation.value;
      transport?.travelMode = travelModeController.value.text;
      transport?.departureTime = _departureTime;
      transport?.arrivalTime = _arrivalTime;
      transport?.date = date;
      transport?.category = category;
    });

    try {
      firestoreFunc.addDayActivity(tripsController.tripId.value, isGroupTrip,
          transportModel.value.toJson());
    } catch (e) {
      log(e.toString());
    }

    addActivityController.activityNameController.value.clear();
    arrivalLocationId.value = '';
    arrivalLocation.value = PlaceDetailsModel();
    departureLocationId.value = '';
    departureLocation.value = PlaceDetailsModel();
    addActivityController.noteController.value.clear();
    travelModeController.value.clear();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
