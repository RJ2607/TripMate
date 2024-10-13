import 'package:flutter/material.dart';
import 'package:tripmate/controller/activity%20controllers/sightseeingController.dart';

import '../../../../constant/widgets/timeRangePickerWidget.dart';

class SightseeingFields extends StatelessWidget {
  bool isGroupTrip;
  SightseeingFields({super.key, 
    required this.isGroupTrip,
  });

  SightseeingController sightseeingController = SightseeingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          controller: sightseeingController.placeNameController.value,
          decoration: const InputDecoration(labelText: "Place Name"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          controller: sightseeingController.locationController.value,
          decoration: const InputDecoration(labelText: "Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              sightseeingController.updateSighseeing(
                isGroupTrip,
                'Sightseeing',
                '${sightseeingController.addActivityController.activityDate.value.toString()} dayactivity',
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
            ),
            child: const Text('Add Sightseeing'),
          ),
        ),
      ],
    );
  }
}
