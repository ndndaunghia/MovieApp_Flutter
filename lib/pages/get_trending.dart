import 'package:flutter/material.dart';

import '../data/api_handle.dart';
import '../models/movie.dart';

class TrendingMovie extends StatefulWidget {
  const TrendingMovie({
    super.key,
  });

  @override
  State<TrendingMovie> createState() => _TrendingMovieState();
}

class _TrendingMovieState extends State<TrendingMovie> {
  final api_handle = ApiHandle();
  Future<List<Movie>>? _movies;

  @override
  void initState() {
    super.initState();
    // _movies = api_handle.fetchData();
    // _movies = api_handle.fetchData('trending/movie/day');
    _movies = api_handle.getTrendingMovie();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _movies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: snapshot.data!
                .map(
                  (movie) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                        height: 240,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
