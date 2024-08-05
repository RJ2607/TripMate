import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunc {
  static String users = 'users';
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> groupTrip =
      db.collection('groupTrip');
  static CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);
  static CollectionReference<Map<String, dynamic>> trips(String uid) =>
      userCollection.doc(uid).collection('trips');

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    return await userCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.first.data());
  }

  static addIndividualTrip(String uid, Map<String, dynamic> data) {
    try {
      trips(uid).add(data);
    } catch (e) {
      print(e);
    }
  }

  static Future getuserByUid(String uid) async {
    // await Future.delayed(const Duration(seconds: 2));
    return await userCollection.doc(uid).get().then((value) => value.data());
  }
}
