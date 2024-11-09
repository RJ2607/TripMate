import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tripmate/controller/activity%20controllers/sightseeingController.dart';
import 'package:tripmate/controller/google%20cloud%20controllers/googleMapContreller.dart';
import 'package:tripmate/utils/widgets/timeRangePickerWidget.dart';

class SightseeingFields extends StatefulWidget {
  bool isGroupTrip;
  SightseeingFields({
    super.key,
    required this.isGroupTrip,
  });

  @override
  State<SightseeingFields> createState() => _SightseeingFieldsState();
}

class _SightseeingFieldsState extends State<SightseeingFields> {
  SightseeingController sightseeingController = SightseeingController();

  final GoogleCloudMapController googleCloudMapController =
      GoogleCloudMapController();

  List<String> suggestions = [];
  List<String> placeIds = [];

  Future<void> fetchSuggestions(String input) async {
    final result = await googleCloudMapController.getAutoCompletePlaces(input);
    setState(() {
      suggestions = result.predictions.map((e) => e.description!).toList();
      placeIds = result.predictions.map((e) => e.placeId!).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            sightseeingController.placeId.value = placeIds[index];
            log(sightseeingController.placeId.value);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeRangePickerWidget(
              label: 'Departure Time',
              isStartTime: true,
            ),
            TimeRangePickerWidget(label: 'Arrival Time', isStartTime: false),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            onPressed: () {
              sightseeingController.updateSighseeing(
                widget.isGroupTrip,
                'Sightseeing',
                sightseeingController.addActivityController.activityDate.value,
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
            ),
            child: const Text('Add Sightseeing'),
          ),
        ),
      ],
    );
  }
}
