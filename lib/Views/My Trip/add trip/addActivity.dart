import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/constant/widgets/timeRangeField.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/category%20fields/LodgingFields.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/category%20fields/restaurantFields.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/category%20fields/sightseeingFields.dart';
import 'package:tripmate/views/My%20Trip/add%20trip/category%20fields/travelFields.dart';

import '../../../controller/dateRangeController.dart';

class AddActivityController extends GetxController {
  Rx<String> selectedCategory = ''.obs;
  Rx<TextEditingController> activityNameController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
}

class AddActivity extends StatelessWidget {
  final AddActivityController addActivityController =
      Get.put(AddActivityController());
  final DateRangePickerController dateRangeController =
      Get.put(DateRangePickerController());

  AddActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Activity'),
        onPressed: () {
          Get.back();
        },
      ),
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
                      dateRangeController.selectedTimeRange.value = null;
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
              TextField(
                controller: addActivityController.activityNameController.value,
                decoration: const InputDecoration(
                  labelText: 'Activity Name',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextField(
                controller: addActivityController.descriptionController.value,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeRangePickerWidget(),
                  Obx(() => DropdownMenu<String>(
                        initialSelection:
                            addActivityController.selectedCategory.value,
                        onSelected: (String? value) {
                          if (value != null) {
                            addActivityController.selectedCategory.value =
                                value;
                          }
                        },
                        enableFilter: true,
                        label: const Text(
                          'Category',
                          style: TextStyle(color: Colors.grey),
                        ),
                        width: MediaQuery.of(context).size.width * 0.55,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: 'Travel',
                            label: 'Travel',
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
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Obx(
                () {
                  switch (addActivityController.selectedCategory.value) {
                    case 'Travel':
                      return TravelFields();
                    case 'Restaurant':
                      return RestaurantFields();
                    case 'Sightseeing':
                      return SightseeingFields();
                    case 'Lodging':
                      return LodgingFields();
                    default:
                      return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
