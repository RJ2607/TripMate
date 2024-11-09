import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tripmate/models/Activities%20Model/restaurantModel.dart';
import 'package:tripmate/utils/flutterBasicsTools.dart';

import '../../models/google cloud models/maps/placeModel.dart';
import '../../utils/firestoreFunc.dart';
import '../../views/My Trip/activity/addActivity.dart';
import '../dateRangeController.dart';
import '../google cloud controllers/googleMapContreller.dart';
import '../trip controllers/tripsController.dart';

class RestaurantController extends GetxController {
  Rx<RestaurantModel> restaurantModel = RestaurantModel().obs;

  AddActivityController addActivityController =
      Get.put(AddActivityController());
  FlutterBasicsTools flutterBasicsTools = FlutterBasicsTools();

  Rx<PlaceDetailsModel> placeDetails = PlaceDetailsModel().obs;
  Rx<String> placeId = ''.obs;
  GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());
  TripsController tripsController = Get.put(TripsController());

  void updateRestaurant(
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
      Get.snackbar('Reservation Time', 'Please select a reservation time');
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
    } catch (e) {}

    restaurantModel.update((restaurant) {
      DateTime _reservationTime = DateTime(
        date.year,
        date.month,
        date.day,
        dateRangeController.selectedStartTimeRange.value!.hour,
        dateRangeController.selectedStartTimeRange.value!.minute,
      );
      restaurant?.activityName =
          addActivityController.activityNameController.value.text;
      restaurant?.note = addActivityController.noteController.value.text;
      restaurant?.placeDetailsModel = placeDetails.value;
      restaurant?.reservationTime = _reservationTime;
      restaurant?.date = date;
      restaurant?.category = category;
    });

    firestoreFunc.addDayActivity(tripsController.tripId.value, isGroupTrip,
        restaurantModel.value.toJson());

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
