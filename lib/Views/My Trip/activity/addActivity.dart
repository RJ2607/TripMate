import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/activity%20controllers/transportController.dart';
import 'package:tripmate/views/My%20Trip/activity/day%20activity/category%20fields/sightseeingFields.dart';

import '../../../controller/dateRangeController.dart';
import 'day activity/category fields/lodgingFields.dart';
import 'day activity/category fields/restaurantFields.dart';
import 'day activity/category fields/transportField.dart';

class AddActivityController extends GetxController {
  Rx<DateTime> activityDate = DateTime.now().obs;
  Rx<String> selectedCategory = ''.obs;
  Rx<TextEditingController> activityNameController =
      TextEditingController().obs;
  Rx<TextEditingController> noteController = TextEditingController().obs;
  Rx<TextEditingController> categoryController = TextEditingController().obs;
}

class AddActivity extends StatelessWidget {
  AddActivity({
    super.key,
    required this.isGroupTrip,
  });
  bool isGroupTrip;
  AddActivityController addActivityController =
      Get.put(AddActivityController());
  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());
  TransportController transportController = Get.put(TransportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      dateRangeController.selectedStartTimeRange.value = null;
                      dateRangeController.selectedEndTimeRange.value = null;
                      addActivityController.activityNameController.value
                          .clear();
                      addActivityController.noteController.value.clear();
                      addActivityController.categoryController.value.clear();
                      addActivityController.selectedCategory.value = '';

                      Get.back(closeOverlays: true);
                    },
                  ),
                  const Text(
                    'Add Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextField(
                controller: addActivityController.activityNameController.value,
                onChanged: (value) {
                  addActivityController.activityNameController.value.text =
                      value;
                },
                decoration: const InputDecoration(
                  labelText: 'Activity Name',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextField(
                controller: addActivityController.noteController.value,
                onChanged: (value) {
                  addActivityController.noteController.value.text = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Notes',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                          width: 0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      // alignment: Alignment.bottomCenter,
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      value: addActivityController.selectedCategory.value == ''
                          ? null
                          : addActivityController.selectedCategory.value,
                      // selectedItemBuilder: (context) => const <Widget>[
                      //   Text('Category'),
                      // ],
                      hint: const Text('Category'),
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: 'Transport',
                          child: Text('Transport'),
                        ),
                        DropdownMenuItem(
                          value: 'Restaurant',
                          child: Text('Restaurant'),
                        ),
                        DropdownMenuItem(
                          value: 'Sightseeing',
                          child: Text('Sightseeing'),
                        ),
                        DropdownMenuItem(
                          value: 'Lodging',
                          child: Text('Lodging'),
                        ),
                      ],
                      onChanged: (String? value) {
                        addActivityController.selectedCategory.value = value!;
                        if (dateRangeController.selectedStartTimeRange.value !=
                            null) {
                          dateRangeController.selectedStartTimeRange.value =
                              null;
                        }
                        if (dateRangeController.selectedEndTimeRange.value !=
                            null) {
                          dateRangeController.selectedEndTimeRange.value = null;
                        }
                      },
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Obx(() {
                if (addActivityController.selectedCategory.value ==
                    'Transport') {
                  return TransportFields(
                    isGroupTrip: isGroupTrip,
                  );
                } else if (addActivityController.selectedCategory.value ==
                    'Sightseeing') {
                  return SightseeingFields(
                    isGroupTrip: isGroupTrip,
                  );
                } else if (addActivityController.selectedCategory.value ==
                    'Restaurant') {
                  return RestaurantFields(
                    isGroupTrip: isGroupTrip,
                  );
                } else if (addActivityController.selectedCategory.value ==
                    'Lodging') {
                  return LodgingFields(
                    isGroupTrip: isGroupTrip,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
