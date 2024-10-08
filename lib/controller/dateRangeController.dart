import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRangePickerController extends GetxController {
  var selectedDateRange = Rxn<DateTimeRange>();
  var selectedStartTimeRange = Rxn<TimeOfDay>();
  var selectedEndTimeRange = Rxn<TimeOfDay>();

  Future<void> pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDateRange.value) {
      selectedDateRange.value = picked;
    }
  }

  // write code for time picker for certain date
  Future<void> pickTimeRange(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      if (isStartTime) {
        selectedStartTimeRange.value = picked;
      } else {
        selectedEndTimeRange.value = picked;
      }
    }
  }
}
