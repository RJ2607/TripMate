import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/userData.dart';

import 'Widgets/profileInfoCard.dart';
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
          title: const Center(child: Text('Profile')),
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
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Yes'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              user.signOut();
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              bgColor: const Color.fromARGB(255, 218, 60, 49),
              forwardIcon: false,
            ),
          ],
        )));
  }
}
