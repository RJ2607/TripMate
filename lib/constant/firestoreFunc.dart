import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';

class FirestoreFunc extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  String users = 'users';
  static FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> groupTrip =
      db.collection('groupTrip');
  CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);
  CollectionReference<Map<String, dynamic>> individualTrip =
      db.collection('individualTrip');

  CollectionReference<Map<String, dynamic>> groupDayActivity(String groupId) =>
      groupTrip.doc(groupId).collection('dayActivity');
  CollectionReference<Map<String, dynamic>> individualDayActivity(
          String tripId) =>
      individualTrip.doc(tripId).collection('dayActivity');

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    return await userCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.first.data());
  }

  Future getUserByUid(String uid) async {
    // await Future.delayed(const Duration(seconds: 2));
    return await userCollection.doc(uid).get().then((value) => value.data());
  }

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

  updateTrip(String uid, Map<String, dynamic> data) {
    try {
      individualTrip.doc(uid).update(data);
    } catch (e) {
      print(e);
    }
  }

  updateGroupTrip(String uid, Map<String, dynamic> data) {
    try {
      groupTrip.doc(data['groupId']).update(data);
    } catch (e) {
      print(e);
    }
  }

  addIndividualTrip(String uid, Map<String, dynamic> data) {
    try {
      individualTrip.add(data).then((value) {
        Get.back();
        Get.snackbar('Success', 'Trip added successfully');

        return value.id;
      });
    } catch (e) {
      print(e);
    }
  }

  addGroupTrip(Map<String, dynamic> data, String uid) {
    try {
      groupTrip.add(data).then((value) {
        Get.back();
        Get.snackbar('Success', 'Trip added successfully');
        return value.id;
      });
    } catch (e) {
      print(e);
    }
  }

  getIndividualTripsStream() {
    return individualTrip.snapshots();
  }

  getGroupTripsStream() {
    return groupTrip.snapshots();
  }

  Future getGroupTripsById(String uid) async {
    return await groupTrip.doc(uid).get().then((value) => value.data());
  }

  Future getIndividualTripById(String tripId) async {
    return await individualTrip.doc(tripId).get().then((value) => value.data());
  }

  addDayActivity(String tripId, String dayId, String category, bool isGroupTrip,
      Map<String, dynamic> data) {
    try {
      if (isGroupTrip) {
        groupDayActivity(tripId)
            .doc(dayId)
            .collection(category)
            .add(data)
            .then((value) {
          Get.back();
          Get.snackbar('Success', 'Activity added successfully');
        });
      } else {
        individualDayActivity(tripId)
            .doc(dayId)
            .collection(category)
            .add(data)
            .then((value) {
          Get.back();
          Get.snackbar('Success', 'Activity added successfully');
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
