import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;
  late PageController _pageController;
  bool _lastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 240),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _pageIndex = value;
                    if (_pageIndex == OnBoardData.onBoardData.length - 1) {
                      _lastPage = true;
                    } else {
                      _lastPage = false;
                    }
                  });
                },
                itemCount: OnBoardData.onBoardData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardImage(
                  image: OnBoardData.onBoardData[index].image,
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    OnBoardData.onBoardData.length,
                    (index) => DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            OnBoardContent(
              title: OnBoardData.onBoardData[_pageIndex].title,
              description: OnBoardData.onBoardData[_pageIndex].description,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  _pageIndex != 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50.0),
                                      onTap: () {
                                        if (_pageIndex > 0) {
                                          _pageIndex--;
                                        } else {
                                          _pageIndex =
                                              OnBoardData.onBoardData.length -
                                                  1;
                                        }

                                        _pageController.animateToPage(
                                          _pageIndex,
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  Spacer(),
                  _lastPage
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50.0),
                                      onTap: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50.0),
                                      onTap: () {
                                        if (_pageIndex <
                                            OnBoardData.onBoardData.length -
                                                1) {
                                          _pageIndex++;
                                        } else {
                                          _pageIndex = 0;
                                        }

                                        _pageController.animateToPage(
                                          _pageIndex,
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}

class OnBoardData {
  final String title;
  final String description;
  final String image;

  OnBoardData({
    required this.title,
    this.description = '',
    required this.image,
  });

  static List<OnBoardData> onBoardData = [
    OnBoardData(
      title: 'TripMate',
      description: 'Your travel companion',
      image: 'assets/lottie/travel.json',
    ),
    OnBoardData(
      title: 'Pack your bags',
      description: 'Plan your trips with ease',
      image: 'assets/lottie/planTrip.json',
    ),
    OnBoardData(
      title: 'Lost ? No worries',
      description: 'Track your location on Maps',
      image: 'assets/lottie/Map.json',
    ),
    OnBoardData(
      title: 'On a budget ?',
      description: 'Track your travel budget with ease',
      image: 'assets/lottie/budget.json',
    ),
  ];
}

class OnBoardImage extends StatelessWidget {
  OnBoardImage({
    super.key,
    required this.image,
  });

  String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Spacer(),
        SizedBox(height: 50),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(child: Lottie.asset(image, fit: BoxFit.cover)),
        ),
      ],
    );
  }
}

class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.title,
    required this.description,
  });

  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 15,
      width: isActive ? 35 : 15,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF479985) : Colors.white,
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
