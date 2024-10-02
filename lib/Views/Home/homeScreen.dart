import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tripmate/controller/loginController.dart';
import 'package:tripmate/views/Home/headerWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      stretchTriggerOffset: 100,
      appBarColor: Theme.of(context).colorScheme.primaryContainer,
      alwaysShowTitle: true,
      
      centerTitle: true,
      alwaysShowLeadingAndAction: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: InkWell(
        child: Icon(
          MingCute.bell_ringing_line,
          color: Theme.of(context).iconTheme.color,
        ),
        onTap: () {
          // show notification
        },
        //add on hover whene implementing notification
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            MingCute.currency_rupee_line,
            color: Theme.of(context).iconTheme.color,
            size: 28,
          ),
          style: Theme.of(context).iconButtonTheme.style,
        ),
      ],
      title: Text(
        'Home',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      headerWidget: const HeaderWidget(),
      body: const [],
    );
  }
}
