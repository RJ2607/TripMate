import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tripmate/models/google%20cloud%20models/maps/placeModel.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/utils/flutterBasicsTools.dart';
import 'package:tripmate/views/My%20Trip/activity/addActivity.dart';

import '../../models/activities Model/sightseeingModel.dart';
import '../dateRangeController.dart';
import '../google cloud controllers/googleMapContreller.dart';
import '../trip controllers/tripsController.dart';

class SightseeingController extends GetxController {
  Rx<SightseeingModel> sightseeingModel = SightseeingModel().obs;
  Rx<PlaceDetailsModel> placeDetails = PlaceDetailsModel().obs;
  Rx<String> placeId = ''.obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());
  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());
  GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateSighseeing(
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
    if (placeId.value.isEmpty) {
      Get.snackbar('Accommodation Name', 'Please select a Accommodation Name');
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

    placeDetails.value = await googleCloudMapController.getPlaceDetails(
      placeId.value,
    );

    Uint8List? image = await googleCloudMapController.getPlacePhoto(
        placeDetails.value.photoRef!, 400, 400);
    Uint8List? storedImage =
        await flutterBasicsTools.readImage(placeDetails.value.photoRef!);
    try {
      if (storedImage == null)
        await flutterBasicsTools.storeImage(
            image!, placeDetails.value.photoRef!);
    } catch (e) {
      log(e.toString());
    }

    sightseeingModel.update((sighseeing) {
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
      sighseeing?.activityName =
          addActivityController.activityNameController.value.text;
      sighseeing?.note = addActivityController.noteController.value.text;
      sighseeing?.placeDetailsModel = placeDetails.value;
      sighseeing?.date = date;

      sighseeing?.departureTime = _departureTime;
      sighseeing?.arrivalTime = _arrivalTime;
      sighseeing?.category = category;
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, isGroupTrip,
        sightseeingModel.value.toJson());

    addActivityController.activityNameController.value.clear();
    addActivityController.noteController.value.clear();
    placeId.value = '';
    placeDetails.value = PlaceDetailsModel();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
