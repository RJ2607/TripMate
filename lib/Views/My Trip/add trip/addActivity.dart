import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/category%20fields/sightseeingFields.dart';

import '../../../controller/dateRangeController.dart';
import 'category fields/lodgingFields.dart';
import 'category fields/restaurantFields.dart';
import 'category fields/transportField.dart';

class AddActivityController extends GetxController {
  Rx<String> selectedCategory = ''.obs;
  Rx<TextEditingController> activityNameController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> categoryController = TextEditingController().obs;
}

class AddActivity extends StatelessWidget {
  AddActivity({super.key});
  AddActivityController addActivityController =
      Get.put(AddActivityController());
  DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());
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
                      Navigator.pop(context);
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
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Activity Name',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Obx(
                () => DropdownMenu(
                    expandedInsets: EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    controller: addActivityController.categoryController.value,
                    enableFilter: true,
                    onSelected: (value) {
                      dateRangeController.selectedStartTimeRange.value = null;
                      dateRangeController.selectedEndTimeRange.value = null;
                      addActivityController.selectedCategory.value = value!;
                    },
                    label: const Text('Category',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    width: MediaQuery.of(context).size.width * 0.55,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(
                        value: 'Transport',
                        label: 'Transport',
                      ),
                      DropdownMenuEntry(
                        value: 'Restaurant',
                        label: 'Restaurant',
                      ),
                      DropdownMenuEntry(
                        value: 'Sightseeing',
                        label: 'Sightseeing',
                      ),
                      DropdownMenuEntry(
                        value: 'Lodging',
                        label: 'Lodging',
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Obx(() {
                if (addActivityController.selectedCategory.value ==
                    'Transport') {
                  return TransportFields();
                } else if (addActivityController.selectedCategory.value ==
                    'Sightseeing') {
                  return const SightseeingFields();
                } else if (addActivityController.selectedCategory.value ==
                    'Restaurant') {
                  return RestaurantFields();
                } else if (addActivityController.selectedCategory.value ==
                    'Lodging') {
                  return LodgingFields();
                } else {
                  return const SizedBox();
                }
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Add Activity"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
