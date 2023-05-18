import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movieapp/models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<UserModel> getUserData(String email) async {
    // final snapshot = await _db.collection('users').doc(email).get();
    final snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).single;

    return userData;
  }
}