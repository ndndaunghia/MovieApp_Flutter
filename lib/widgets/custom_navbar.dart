import 'package:flutter/material.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/pages/search_page.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: botnavColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: Icon(Icons.home, size: 28, color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
          child: Icon(Icons.search, size: 28, color: Colors.white),
        ),
        InkWell(
          onTap: () {},
          child: Icon(Icons.favorite, size: 28, color: Colors.white),
        ),
        InkWell(
          onTap: () {},
          child: Icon(Icons.person, size: 28, color: Colors.white),
        ),
      ]),
    );
  }
}
