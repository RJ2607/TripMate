import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/controller/auth%20controllers/userData.dart';

class LoginController extends GetxController {
  FirestoreFunc fireStoreFunc = Get.put(FirestoreFunc());
  UserData user = Get.find();
  RxBool isLoading = false.obs;
  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      log('signing in');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      log('getting auth');
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential.value = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        return value;
      });
      user.user.value = userCredential.value!.user;
      fireStoreFunc.uploadUser(user.user.value!);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
    Get.offAllNamed('/navigation');
  }
}
