import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import 'dayActivity.dart';

class DaySelect extends StatefulWidget {
  DateTime startDate;
  DateTime endDate;
  int totalDays;
  int startWeekDay;

  DaySelect(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.totalDays,
      required this.startWeekDay});

  @override
  State<DaySelect> createState() => _DaySelectState();
}

class _DaySelectState extends State<DaySelect> {
  Map<int, String> days = {
    0: 'Sunday',
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
  };

  // Color selectedColor = Colors.blue;

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
                    child: const Icon(Bootstrap.arrow_left),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Dates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Plan every of your selected dates',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: List.generate(widget.totalDays, (index) {
                    // log((days[(widget.startWeekDay + index) % 7]).toString());
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DayActivity(
                              weekDay: days[(widget.startWeekDay + index) % 7]!,
                              date: widget.startDate.add(Duration(days: index)),
                              dayNumber: index + 1,
                            ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${widget.startDate.day + index}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              days[(widget.startWeekDay + index) % 7]!.substring(0, 3),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
