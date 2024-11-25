import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/activity%20controllers/lodgingController.dart';

import '../../../../../controller/google cloud controllers/googleMapContreller.dart';
import '../../../../../utils/widgets/timeRangePickerWidget.dart';

class LodgingFields extends StatefulWidget {
  bool isGroupTrip;
  LodgingFields({
    super.key,
    required this.isGroupTrip,
  });

  @override
  State<LodgingFields> createState() => _LodgingFieldsState();
}

class _LodgingFieldsState extends State<LodgingFields> {
  LodgingController lodgingController = Get.put(LodgingController());

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
    return Obx(
      () => Column(
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
              lodgingController.placeId.value = placeIds[index];
              log(lodgingController.placeId.value);
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
          Row(
            children: [
              Checkbox(
                value: lodgingController.isCheckOut.value,
                onChanged: (value) {
                  lodgingController.isCheckOut.value = value!;
                },
              ),
              Text(
                "Check Out",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ],
          ),
          if (lodgingController.isCheckOut.value)
            TimeRangePickerWidget(
              label: 'Check Out Time',
              isStartTime: false,
            )
          else
            TimeRangePickerWidget(
              label: 'Check In Time',
              isStartTime: true,
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              onPressed: () {
                lodgingController.updateLodging(
                  widget.isGroupTrip,
                  'Lodging',
                  lodgingController.addActivityController.activityDate.value,
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Add Lodging',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
