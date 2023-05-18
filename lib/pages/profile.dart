import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/auth_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  List<String> docIds = [];
  List<DocumentSnapshot> docs = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        // docIds.add(element.id);
        print(element.reference);
        docIds.add(element.id);
      });
    });
  }



  void _onPressed() {
    FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocIds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(docIds[index]),
                      );
                    });
              } else {
                return const Placeholder();
              }
            },
          ))
        ],
      )),
    );
  }
}
