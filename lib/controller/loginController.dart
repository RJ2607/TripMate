import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tripmate/config/firestoreOp.dart';
import 'package:tripmate/controller/userData.dart';

class LoginController extends GetxController {
  UserData user = Get.find();
  RxBool isLoading = false.obs;
  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);
  // login with google
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // Trigger the authentication flow
      log('signing in');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      log('getting auth');
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      // exception is coming Null check operator used on a null value
      userCredential.value = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        return value;
      });
      user.user.value = userCredential.value!.user;
      FireStoreOp.uploadUser(user.user.value!);
    } catch (e) {
      log('hehehe ' + e.toString());
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
    Get.toNamed('/navigation');
  }
}
