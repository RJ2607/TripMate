import 'package:flutter/material.dart';
import 'package:tripmate/constant/widgets/timeRangePickerWidget.dart';

class TransportFields extends StatelessWidget {
  const TransportFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: "Travel Mode"),
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
          decoration: InputDecoration(labelText: "Departure Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Arrival Location"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ],
    );
  }
}
