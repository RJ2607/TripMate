import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirestoreFunc extends GetxController {
  @override
  onInit() {
    super.onInit();
    // getUserByUid(FirebaseAuth.instance.currentUser!.uid);
    user = FirebaseAuth.instance.currentUser!;
  }

  late User user;
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

  deleteIndividualTrip(String uid) {
    try {
      individualTrip.doc(uid).delete().then((value) {
        Get.snackbar('Success', 'Trip successfully deleted');
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  deleteGroupTrip(String uid) {
    try {
      groupTrip.doc(uid).delete().then((value) {
        Get.snackbar('Success', 'Trip successfully deleted');
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
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

  addDayActivity(String tripId, bool isGroupTrip, Map<String, dynamic> data) {
    try {
      if (isGroupTrip) {
        groupDayActivity(tripId).add(data);
      } else {
        individualDayActivity(tripId).add(data);
      }
      Get.back();
      Get.snackbar('Success', 'Activity added successfully');
    } catch (e) {
      print(e);
    }
  }

  getDayActivity(String tripId, bool isGroupTrip) {
    try {
      if (isGroupTrip) {
        return groupDayActivity(tripId).snapshots();
      } else {
        return individualDayActivity(tripId).snapshots();
      }
    } catch (e) {
      print(e);
    }
  }
}
