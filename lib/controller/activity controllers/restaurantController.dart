import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/models/Activities%20Model/restaurantModel.dart';

import '../../constant/firestoreFunc.dart';
import '../../views/My Trip/activity/addActivity.dart';
import '../dateRangeController.dart';
import '../tripsController.dart';

class RestaurantController extends GetxController {
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  Rx<TextEditingController> accommodationController =
      TextEditingController().obs;

  Rx<TextEditingController> locationController = TextEditingController().obs;

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateRestaurant(
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
    if (accommodationController.value.text.isEmpty) {
      Get.snackbar('Accommodation Name', 'Please enter an accommodation name');
      return;
    }
    if (locationController.value.text.isEmpty) {
      Get.snackbar('Location', 'Please enter a location');
      return;
    }
    if (dateRangeController.selectedStartTimeRange.value == null) {
      Get.snackbar('Reservation Time', 'Please select a reservation time');
      return;
    }

    restaurantModel.update((restaurant) {
      restaurant?.activityName =
          addActivityController.activityNameController.value.text;
      restaurant?.note = addActivityController.noteController.value.text;
      restaurant?.accommodationName = accommodationController.value.text;

      restaurant?.location = locationController.value.text;
      restaurant?.reservationTime =
          dateRangeController.selectedStartTimeRange.value.toString();
      restaurant?.date = date;
      restaurant?.category = category;
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, isGroupTrip,
        restaurantModel.value.toJson());

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
