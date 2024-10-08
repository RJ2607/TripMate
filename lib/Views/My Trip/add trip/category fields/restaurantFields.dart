import 'package:flutter/material.dart';
import 'package:tripmate/constant/widgets/timeRangePickerWidget.dart';

class RestaurantFields extends StatelessWidget {
  const RestaurantFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: "Accommodation Name"),
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
        TimeRangePickerWidget(label: 'Reservation Time', isStartTime: true),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ],
    );
  }
}
