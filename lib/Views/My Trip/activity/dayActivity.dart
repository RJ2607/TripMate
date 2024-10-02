import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add trip/addActivity.dart';

class DayActivity extends StatefulWidget {
  String weekDay;
  DateTime date;
  int dayNumber;

  DayActivity({
    super.key,
    required this.weekDay,
    required this.date,
    required this.dayNumber,
  });

  @override
  State<DayActivity> createState() => _DayActivityState();
}

class _DayActivityState extends State<DayActivity> {
  //dummy data for chips
  List<String> categories = [
    'Food',
    'Transport',
    'Accomodation',
    'Activity',
    'Miscellaneous',
  ];

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
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Day ${widget.dayNumber}',
                    style: const TextStyle(
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
              Wrap(
                spacing: 10,
                children: [
                  ...List.generate(categories.length + 1, (index) {
                    if (index == categories.length) {
                      return GestureDetector(
                        onTap: () => Get.to(() => AddActivity()),
                        child: Chip(
                          label: const Icon(Icons.add),
                          padding: const EdgeInsets.all(8),
                          shape: const CircleBorder(),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () {},
                      child: Chip(
                        label: Text(categories[index]),
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
