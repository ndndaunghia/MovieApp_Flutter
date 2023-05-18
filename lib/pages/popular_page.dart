import 'package:flutter/material.dart';
import 'package:movieapp/pages/list_movie.dart';

import '../data/api_handle.dart';
import '../models/movie.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Popular Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See More',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListMovie(type: 'popular'),
          )
        ],
      ),
    );
  }
}
