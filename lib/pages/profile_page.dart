import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/data/profile_controler.dart';
import 'package:movieapp/models/user.dart';

import '../auth/auth_controller.dart';

class ProfilePages extends StatefulWidget {
  ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  final User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final controler = Get.put(ProfileControler());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: controler.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${userData.name}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${userData.email}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  );
                  // return const Center(
                  //   child: Text("Error", style: TextStyle(fontSize: 30, color: Colors.red),),
                  // );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
