import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserData extends GetxController {
  Rx<User?> user = Rx(null);

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    user.value = auth.currentUser;
  }
}
