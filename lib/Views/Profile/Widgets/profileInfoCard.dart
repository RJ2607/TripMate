import 'package:flutter/material.dart';

import '../../../controller/auth controllers/userData.dart';
import 'neonAvatar.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
        ),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.user.value!.displayName as String,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(user.user.value!.email as String),
            ],
          ),
          Stack(alignment: Alignment.center, children: [
            // create a circular overlay behind the image which giveglow effect
            Container(
              height: MediaQuery.of(context).size.height * 0.1386,
              width: MediaQuery.of(context).size.height * 0.1386,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
            ),

            NeonAvatar(imagePath: user.user.value!.photoURL as String),
          ]),
        ],
      ),
    );
  }
}
