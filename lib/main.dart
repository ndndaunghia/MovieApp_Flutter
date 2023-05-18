import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/data/database_controller.dart';
import 'package:movieapp/auth/main_page.dart';
import 'package:get/get.dart';
import 'auth/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(DatabaseController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true );
  final dbC = Get.put(DatabaseController(), permanent: true);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
      ),
      // home: const HomePage(),
      // home: const SignUpPage(),
      home: MainPage(),
    );
  }
}
