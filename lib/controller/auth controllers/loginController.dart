import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tripmate/utils/firestoreFunc.dart';
import 'package:tripmate/controller/auth%20controllers/userData.dart';

import '../../models/userModel.dart';

class LoginController extends GetxController {
  // FirestoreFunc fireStoreFunc = Get.put(FirestoreFunc());
  static FirebaseFirestore db = FirebaseFirestore.instance;
  String users = 'users';
  UserData user = Get.find();
  RxBool isLoading = false.obs;
  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);
  CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);

uploadUser(User user) {
    try {
      UserModel userModel = UserModel(
        uid: user.uid,
        name: user.displayName!,
        email: user.email!,
        // phone: user.phoneNumber!,
        profile: user.photoURL!,
      );
      userCollection.doc(user.uid).get().then((doc) {
        if (!doc.exists) {
          userCollection.doc(user.uid).set(userModel.toJson());
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

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
      uploadUser(user.user.value!);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
    Get.offAllNamed('/navigation');
  }
}
