import 'package:cloud_firestore/cloud_firestore.dart';

class AddTripsController {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> users =
      db.collection('users');
  static CollectionReference<Map<String, dynamic>> trips(String uid) =>
      users.doc(uid).collection('trips');
  static CollectionReference<Map<String, dynamic>> groupTrip =
      db.collection('groupTrip');

  void addIndividualTrip(String uid, Map<String, dynamic> data) {
    try {
      trips(uid).add(data);
    } catch (e) {
      print(e);
    }
  }
  
}
