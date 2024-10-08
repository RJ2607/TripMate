import 'package:flutter/material.dart';

import '../../../../constant/widgets/timeRangePickerWidget.dart';

class SightseeingFields extends StatelessWidget {
  const SightseeingFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: "Place Name"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Location"),
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
      ],
    );
  }
}
