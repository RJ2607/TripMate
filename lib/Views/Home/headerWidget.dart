import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  List<Map<String, dynamic>> get _carouselItems => [
        {
          'title': 'Plan your trip',
          'subtitle': 'Create detailed itineraries with ease.',
        },
        {
          'title': 'Explore Maps',
          'subtitle': 'Discover and save places on an interactive map.',
        },
        {
          'title': 'Get Recommendations',
          'subtitle': 'Personalized suggestions tailored to your preferences.',
        },
        {
          'title': 'Collaborate and Share',
          'subtitle': 'Plan trips with friends and family in real-time.',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Theme.of(context).brightness == Brightness.dark
              ? const AssetImage('assets/images/dark_home_wallpaper.jpeg')
              : const AssetImage('assets/images/light_home_wallpaper.jpeg'),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
      child: CarouselSlider.builder(
        itemCount: _carouselItems.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _carouselItems[index]['title'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.006,
                ),
                Text(
                  _carouselItems[index]['subtitle'],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.14,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 7),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 2.0,
          initialPage: 0,
        ),
      ),
    );
  }
}
