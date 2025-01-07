import 'package:flutter/material.dart';
import 'package:tripmate/utils/responsive.dart';

import '../../../../controller/auth controllers/userData.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.sH(context),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 36.sW(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(user.user.value!.displayName.toString(),
                  style: TextStyle(
                    fontSize: 24.sW(context),
                  )),
              Text(user.user.value!.email.toString(),
                  style: TextStyle(
                    fontSize: 16.sW(context),
                    color: Theme.of(context).hintColor,
                  )),
            ],
          ),
          Container(
            height: 120.sH(context),
            width: 120.sW(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(user.user.value!.photoURL.toString()),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
