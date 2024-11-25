import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/activity%20controllers/restaurantController.dart';
import 'package:tripmate/utils/widgets/timeRangePickerWidget.dart';

import '../../../../../controller/google cloud controllers/googleMapContreller.dart';

class RestaurantFields extends StatefulWidget {
  bool isGroupTrip;
  RestaurantFields({
    super.key,
    required this.isGroupTrip,
  });

  @override
  State<RestaurantFields> createState() => _RestaurantFieldsState();
}

class _RestaurantFieldsState extends State<RestaurantFields> {
  RestaurantController restaurantController = Get.put(RestaurantController());

  final GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  List<String> suggestions = [];

  List<String> placeIds = [];

  Future<void> fetchSuggestions(String input) async {
    final result = await googleCloudMapController.getAutoCompletePlaces(input);
    if (mounted) {
      setState(() {
        suggestions = result.predictions.map((e) => e.description!).toList();
        placeIds = result.predictions.map((e) => e.placeId!).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            // Trigger async function to fetch data
            fetchSuggestions(textEditingValue.text);
            return suggestions;
          },
          onSelected: (String selection) {
            final index = suggestions.indexOf(selection);
            restaurantController.placeId.value = placeIds[index];
            log(restaurantController.placeId.value);
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Accommodation Name',
              ),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TimeRangePickerWidget(label: 'Reservation Time', isStartTime: true),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              restaurantController.updateRestaurant(
                widget.isGroupTrip,
                'Restaurant',
                restaurantController.addActivityController.activityDate.value,
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Add Restaurant"),
          ),
        ),
      ],
    );
  }
}
