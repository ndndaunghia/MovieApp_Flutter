import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/pages/favorite_page.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/pages/search_page.dart';

import '../pages/profile.dart';
import '../pages/profile_page.dart';

class GNavBar extends StatefulWidget {
  const GNavBar({super.key});

  @override
  State<GNavBar> createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  int _currentIndex = 0;

  static List<Widget> navScreens = <Widget>[
    const HomePage(),
    const SearchPage(),
    FavoritesPage(),
    ProfilePages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navScreens.elementAt(_currentIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          gap: 8,
          backgroundColor: bgColor,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.red,
          padding: const EdgeInsets.all(12),
          duration: const Duration(milliseconds: 400),
          debug: true,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
