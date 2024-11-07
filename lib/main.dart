import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'controller/auth controllers/userData.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String googleCloudKey = dotenv.env['googleCloudKey'] ?? '';

  const platform = MethodChannel('com.example.tripmate/api_key');
  platform.invokeMethod('setApiKey', {'apiKey': googleCloudKey});
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserData());
  runApp(const App());
}
