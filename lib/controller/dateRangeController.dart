import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRangePickerController extends GetxController {
  var selectedDateRange = Rxn<DateTimeRange>();

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
}
