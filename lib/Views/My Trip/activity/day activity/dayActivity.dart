import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/trip%20controllers/tripsController.dart';
import 'package:tripmate/utils/firestoreFunc.dart';

import '../addActivity.dart';
import 'actvity card/lodgingCard.dart';
import 'actvity card/restaurantCard.dart';
import 'actvity card/sightseeingCard.dart';
import 'actvity card/transportCard.dart';

class DayActivity extends StatefulWidget {
  DayActivity({
    super.key,
  });

  @override
  State<DayActivity> createState() => _DayActivityState();
}

class _DayActivityState extends State<DayActivity> {
  TripsController tripsController = Get.put(TripsController());
  FirestoreFunc firestoreFunc = Get.put(FirestoreFunc());

  AddActivityController addActivityController =
      Get.put(AddActivityController());

  //dummy data for chips
  List<String> categories = [
    'All',
    'Transport',
    'Lodging',
    'Restaurant',
    'Sightseeing',
  ];

  int selectedCategories = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.03,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopBar(context),
              buildCategoryChips(context),
              SingleChildScrollView(
                  child: Column(
                children: [
                  buildActivityStream(),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Column(
          children: [
            Text(
              'Day ${addActivityController.dayNumber.value}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                '${addActivityController.activityDate.value.day} ${addActivityController.weekDay.value}, ${addActivityController.activityDate.value.year}'),
          ],
        ),
        GestureDetector(
            onTap: () =>
                Get.toNamed('/mytrip/daySelect/dayActivity/addActivity'),
            child: Chip(
              label: Icon(
                Icons.add,
                size: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ))
      ],
    );
  }

  ChipsChoice<int> buildCategoryChips(BuildContext context) {
    return ChipsChoice<int>.single(
      spacing: 5,
      value: selectedCategories,
      onChanged: (val) => setState(() => selectedCategories = val),
      choiceItems: C2Choice.listFrom<int, String>(
        source: categories,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      // wrapCrossAlignment: WrapCrossAlignment.end,
      wrapped: true,
      choiceStyle: C2ChoiceStyle(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        color: Theme.of(context).textTheme.bodySmall!.color!,
        borderColor: Theme.of(context).primaryColor,
      ),
      choiceActiveStyle: C2ChoiceStyle(
        backgroundColor:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
        color: Theme.of(context).textTheme.bodySmall!.color!,
        borderColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildActivityStream() {
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreFunc.getDayActivity(
            tripsController.tripId.value, tripsController.isGroupTrip.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('No data found'),
            );
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var date = new DateTime.fromMillisecondsSinceEpoch(
                  data[index]['date'].seconds * 1000);

              if (addActivityController.activityDate.value == date) {
                if (categories[selectedCategories] == 'All') {
                  if (data[index]['category'] == 'Lodging') {
                    return LodgingCard(data, index);
                  } else if (data[index]['category'] == 'Transport') {
                    return TransportCard(data, index);
                  } else if (data[index]['category'] == 'Restaurant') {
                    return RestaurantCard(data, index);
                  } else if (data[index]['category'] == 'Sightseeing') {
                    return SightseeingCard(data, index);
                  }
                }
                if (snapshot.data!.docs[index]['category'] == 'Lodging' &&
                    categories[selectedCategories] == 'Lodging') {
                  return LodgingCard(data, index);
                } else if (snapshot.data!.docs[index]['category'] ==
                        'Transport' &&
                    categories[selectedCategories] == 'Transport') {
                  return TransportCard(data, index);
                } else if (snapshot.data!.docs[index]['category'] ==
                        'Restaurant' &&
                    categories[selectedCategories] == 'Restaurant') {
                  return RestaurantCard(data, index);
                } else if (snapshot.data!.docs[index]['category'] ==
                        'Sightseeing' &&
                    categories[selectedCategories] == 'Sightseeing') {
                  return SightseeingCard(data, index);
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        });
  }
}
