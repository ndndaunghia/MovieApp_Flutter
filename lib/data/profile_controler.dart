import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movieapp/data/user_repo.dart';

import '../auth/auth_controller.dart';
import '../models/user.dart';

class ProfileControler extends GetxController {
  static ProfileControler get instance => Get.find();
  final _auth = Get.put(AuthController());
  final userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _auth.getUserEmail();
    if (email != null) {
      return userRepo.getUserData(email);
    } else {
      Get.snackbar('Error', 'No user found');
    }
  }
}
