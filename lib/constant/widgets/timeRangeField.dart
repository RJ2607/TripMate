import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dateRangeController.dart';

class TimeRangePickerWidget extends StatelessWidget {
  final DateRangePickerController controller =
      Get.put(DateRangePickerController());

  TimeRangePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDateRangePicker(context);
  }

  Widget _buildDateRangePicker(BuildContext context) {
    String startTime;
    final localizations = MaterialLocalizations.of(context);
    final formatter = localizations;

    return GestureDetector(
      onTap: () => controller.pickTimeRange(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.09,
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
            startTime = controller.selectedTimeRange.value != null
                ? formatter.formatTimeOfDay(controller.selectedTimeRange.value!)
                : 'Start time';

            log(startTime.toString());

            return _buildDateField(context, 'Start time', startTime);
          }),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String label, String value) {
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
