import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/widgets/timeRangePickerWidget.dart';
import 'package:tripmate/controller/activity%20controllers/restaurantController.dart';

import '../../addActivity.dart';

class RestaurantFields extends StatelessWidget {
  bool isGroupTrip;
  RestaurantFields({
    super.key,
    required this.isGroupTrip,
  });

  AddActivityController addActivityController =
      Get.put(AddActivityController());
  RestaurantController restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: restaurantController.accommodationController.value,
          decoration: const InputDecoration(labelText: "Accommodation Name"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          controller: restaurantController.locationController.value,
          decoration: const InputDecoration(labelText: "Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TimeRangePickerWidget(label: 'Reservation Time', isStartTime: true),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              if (addActivityController.selectedCategory.value ==
                  'Restaurant') {
                restaurantController.updateRestaurant(
                  isGroupTrip,
                  addActivityController.selectedCategory.value,
                  addActivityController.activityDate.value,
                );
              }
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
            child: const Text("Add Restaurant"),
          ),
        ),
      ],
    );
  }
}
