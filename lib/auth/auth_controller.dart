import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUserId() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  String getUserEmail() {
    final User? user = _auth.currentUser;
    final email = user!.email;
    return email!;
  }
}
