import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  // final String phone;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.phone,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      // "phone": phone,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],

      // id: snapshot['id'],
      // name: snapshot['name'],
      // email: snapshot['email'],
      // password: snapshot['password'],
      // phone: snapshot['phone'],
    );
  }
}
