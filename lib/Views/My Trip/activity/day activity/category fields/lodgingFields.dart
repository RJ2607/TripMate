import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/activity%20controllers/lodgingController.dart';

import '../../../../../constant/widgets/timeRangePickerWidget.dart';

class LodgingFields extends StatelessWidget {
  bool isGroupTrip;
  LodgingFields({super.key, 
    required this.isGroupTrip,
  });

  LodgingController lodgingController = Get.put(LodgingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: lodgingController.accommodationController.value,
            decoration: const InputDecoration(labelText: "Accommodation Name"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            controller: lodgingController.locationController.value,
            decoration: const InputDecoration(labelText: "Location"),
          ),
          Row(
            children: [
              Checkbox(
                value: lodgingController.isCheckOut.value,
                onChanged: (value) {
                  lodgingController.isCheckOut.value = value!;
                },
              ),
              Text(
                "Check Out",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ],
          ),
          if (lodgingController.isCheckOut.value)
            TimeRangePickerWidget(
              label: 'Check Out Time',
              isStartTime: false,
            )
          else
            TimeRangePickerWidget(
              label: 'Check In Time',
              isStartTime: true,
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: () {
                lodgingController.updateLodging(
                  isGroupTrip,
                  'Lodging',
                  lodgingController.addActivityController.activityDate.value,
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Add Lodging',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
