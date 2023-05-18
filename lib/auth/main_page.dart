import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/pages/sign_in_page.dart';
import 'package:movieapp/widgets/gg_navbar.dart';

import '../pages/home_page.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            // return const HomePage();
            return const GNavBar();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}