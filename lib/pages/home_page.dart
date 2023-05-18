import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/pages/popular_page.dart';
import 'package:movieapp/pages/upcoming_page.dart';
import '../models/movie.dart';
import 'trending_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Movie> movies = [];
  TextEditingController searchController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.person,
            size: 32,
          ),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.email!}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              maxLines: 2,
            ),
            const Text(
              'What do you want to watch today?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 32,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: searchColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
          const UpComing(),
          const TrendingPage(),
          const PopularPage(),
        ],
      )),
      // bottomNavigationBar: const CustomNavBar(),
    );
  }
}
