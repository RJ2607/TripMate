import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/widgets/timeRangePickerWidget.dart';

class LodgingFields extends StatelessWidget {
  LodgingFields({super.key});

  Rx<bool> isCheckOut = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
          Row(
            children: [
              Checkbox(
                value: isCheckOut.value,
                onChanged: (value) {
                  isCheckOut.value = value!;
                },
              ),
              Text(
                "Check Out",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ],
          ),
          if (isCheckOut.value)
            TimeRangePickerWidget(
              label: 'Check Out Time',
              isStartTime: true,
            )
          else
            TimeRangePickerWidget(
              label: 'Check In Time',
              isStartTime: true,
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ],
      ),
    );
  }
}
