import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tripmate/controller/dateRangeController.dart';
import 'package:tripmate/controller/google%20cloud%20controllers/googleMapContreller.dart';
import 'package:tripmate/models/Activities%20Model/lodgingModel.dart';
import 'package:tripmate/models/google%20cloud%20models/maps/placeModel.dart';
import 'package:tripmate/utils/flutterBasicsTools.dart';

import '../../utils/firestoreFunc.dart';
import '../../views/My Trip/activity/addActivity.dart';
import '../trip controllers/tripsController.dart';

class LodgingController extends GetxController {
  Rx<LodgingModel> lodgingModel = LodgingModel().obs;
  Rx<PlaceDetailsModel> placeDetails = PlaceDetailsModel().obs;
  Rx<String> placeId = ''.obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  Rx<bool> isCheckOut = false.obs;

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateLodging(
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

    lodgingModel.update((lodging) {
      if (isCheckOut.value) {
        DateTime _checkOutTime = DateTime(
          date.year,
          date.month,
          date.day,
          dateRangeController.selectedEndTimeRange.value!.hour,
          dateRangeController.selectedEndTimeRange.value!.minute,
        );
        lodging?.checkOutTime = _checkOutTime;
      } else {
        DateTime _checkInTime = DateTime(
          date.year,
          date.month,
          date.day,
          dateRangeController.selectedStartTimeRange.value!.hour,
          dateRangeController.selectedStartTimeRange.value!.minute,
        );
        lodging?.checkInTime = _checkInTime;
      }
      lodging?.activityName =
          addActivityController.activityNameController.value.text;
      lodging?.note = addActivityController.noteController.value.text;
      lodging?.isCheckOut = isCheckOut.value;
      lodging?.date = date;
      lodging?.placeDetailsModel = placeDetails.value;
      lodging?.category = category;
    });

    firestoreFunc.addDayActivity(
        tripsController.tripId.value, isGroupTrip, lodgingModel.value.toJson());

    placeDetails.value = PlaceDetailsModel();
    placeId.value = '';
    addActivityController.activityNameController.value.clear();
    addActivityController.noteController.value.clear();
    dateRangeController.selectedStartTimeRange.value = null;
    dateRangeController.selectedEndTimeRange.value = null;
    addActivityController.categoryController.value.clear();
    addActivityController.selectedCategory.value = '';
  }
}
