import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripmate/models/userModel.dart';

class FireStoreOp {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get userCollection =>
      _firestore.collection('users');

  static uploadUser(User user) {
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
}
