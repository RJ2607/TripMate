import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/userData.dart';

import 'Widgets/profileIbfoCard.dart';
import 'Widgets/profileTile.dart';

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
        appBar: AppBar(
          title: Center(child: Text('Profile')),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: Column(
          children: [
            ProfileInfoCard(user: user),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ProfileTile(
              tileText: 'Edit Profile',
              icon: Clarity.edit_line,
              onTap: () {},
              bgColor: Theme.of(context).primaryColor,
            ),
            ProfileTile(
              tileText: 'Logout',
              icon: Clarity.logout_line,
              onTap: () {
                user.signOut();
              },
              bgColor: const Color.fromARGB(255, 218, 60, 49),
              forwardIcon: false,
            ),
          ],
        )));
  }
}
