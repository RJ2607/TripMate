import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dateRangeController.dart';

class TimeRangePickerWidget extends StatelessWidget {
  final DateRangePickerController controller =
      Get.put(DateRangePickerController());

  final String label;
  final bool isStartTime;

  TimeRangePickerWidget({
    required this.label,
    required this.isStartTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isStartTime) {
      return GestureDetector(
        onTap: () =>
            controller.pickTimeRange(context, isStartTime: isStartTime),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.093,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(24),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 0.5,
            ),
          ),
          child: IntrinsicHeight(
            child: Obx(() {
              String time = controller.selectedStartTimeRange.value != null
                  ? MaterialLocalizations.of(context)
                      .formatTimeOfDay(controller.selectedStartTimeRange.value!)
                  : label;

              return _buildTimeField(context, label, time);
            }),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () =>
            controller.pickTimeRange(context, isStartTime: isStartTime),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.093,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(24),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 0.5,
            ),
          ),
          child: IntrinsicHeight(
            child: Obx(() {
              String time = controller.selectedEndTimeRange.value != null
                  ? MaterialLocalizations.of(context)
                      .formatTimeOfDay(controller.selectedEndTimeRange.value!)
                  : label;

              return _buildTimeField(context, label, time);
            }),
          ),
        ),
      );
    }
  }

  Widget _buildTimeField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleSmall!.color,
            fontSize: MediaQuery.of(context).size.width * 0.03,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleSmall!.color,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
      ],
    );
  }
}
