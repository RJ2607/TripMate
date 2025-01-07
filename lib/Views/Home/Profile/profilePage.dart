import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/auth%20controllers/userData.dart';
import 'package:tripmate/utils/responsive.dart';

import 'Widgets/profileInfoCard.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserData user = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.sH(context),
                    left: 16.sW(context),
                    right: 16.sW(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Iconsax.arrow_left_2_outline)),
                      SizedBox(height: 16.sH(context)),
                      ProfileInfoCard(user: user),
                      SizedBox(height: 32.sH(context)),
                      Text('Profile Details',
                          style: TextStyle(
                            fontSize: 24.sW(context),
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(height: 16.sH(context)),
                      Text('Bookmark Trips',
                          style: TextStyle(
                            fontSize: 24.sW(context),
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(height: 16.sH(context)),
                      Text('Trip Stats',
                          style: TextStyle(
                            fontSize: 24.sW(context),
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 170.sH(context),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/profileAsset.jpg'),
                          fit: BoxFit.fitWidth)),
                )
              ],
            )));
  }
}
