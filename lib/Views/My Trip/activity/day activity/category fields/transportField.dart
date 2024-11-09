import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/activity%20controllers/transportController.dart';
import 'package:tripmate/controller/google%20cloud%20controllers/googleMapContreller.dart';
import 'package:tripmate/utils/widgets/timeRangePickerWidget.dart';

class TransportFields extends StatefulWidget {
  bool isGroupTrip;
  TransportFields({
    super.key,
    required this.isGroupTrip,
  });

  @override
  State<TransportFields> createState() => _TransportFieldsState();
}

class _TransportFieldsState extends State<TransportFields> {
  TransportController transportController = Get.put(TransportController());

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
            transportController.departureLocationId.value = placeIds[index];
            setState(() {
              placeIds = [];
              suggestions = [];
            });
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Departure Location',
              ),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
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
            transportController.arrivalLocationId.value = placeIds[index];
            setState(() {
              placeIds = [];
              suggestions = [];
            });
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Arrival Location',
              ),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormField(
          controller: transportController.travelModeController.value,
          decoration: const InputDecoration(labelText: "Travel Mode"),
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
              transportController.updateTransport(
                widget.isGroupTrip,
                'Transport',
                transportController.addActivityController.activityDate.value,
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
            child: const Text("Add Transport"),
          ),
        ),
      ],
    );
  }
}
