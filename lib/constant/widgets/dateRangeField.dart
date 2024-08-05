import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/dateRangeController.dart';

class DateRangePickerWidget extends StatelessWidget {
  final DateRangePickerController controller =
      Get.put(DateRangePickerController());

  @override
  Widget build(BuildContext context) {
    return _buildDateRangePicker(context);
  }

  Widget _buildDateRangePicker(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return GestureDetector(
      onTap: () => controller.pickDateRange(context),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.1,
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
            final startDate = controller.selectedDateRange.value != null
                ? formatter.format(controller.selectedDateRange.value!.start)
                : 'Start day';
            final endDate = controller.selectedDateRange.value != null
                ? formatter.format(controller.selectedDateRange.value!.end)
                : 'End day';

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDateField(context, 'Start day', startDate),
                VerticalDivider(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  thickness: 1.0,
                ),
                _buildDateField(context, 'End day', endDate),
              ],
            );
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
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleSmall!.color,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
