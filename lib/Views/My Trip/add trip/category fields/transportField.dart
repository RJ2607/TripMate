import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/widgets/timeRangePickerWidget.dart';
import 'package:tripmate/controller/activity%20controllers/transportController.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/addActivity.dart';

class TransportFields extends StatelessWidget {
  bool isGroupTrip;
  TransportFields({
    super.key,
    required this.isGroupTrip,
  });

  TransportController transportController = Get.put(TransportController());

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: transportController.travelModeController.value,
          decoration: const InputDecoration(labelText: "Travel Mode"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeRangePickerWidget(
              label: 'Departure Time',
              isStartTime: true,
            ),
            TimeRangePickerWidget(label: 'Arrival Time', isStartTime: false),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          controller: transportController.departureLocationController.value,
          decoration: const InputDecoration(labelText: "Departure Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          controller: transportController.arrivalLocationController.value,
          decoration: const InputDecoration(labelText: "Arrival Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              if (addActivityController.selectedCategory.value == 'Transport') {
                transportController.updateTransport(
                  isGroupTrip,
                  addActivityController.selectedCategory.value,
                  '${addActivityController.activityDate.value.toString()} dayactivity',
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
            child: const Text("Add Transport"),
          ),
        ),
      ],
    );
  }
}
