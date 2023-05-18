import 'package:flutter/material.dart';
import 'package:movieapp/pages/movie_detail.dart';
import '../data/api_handle.dart';
import '../models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListMovie extends StatefulWidget {
  final String type;
  const ListMovie({
    super.key,
    required this.type,
  });

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  final api_handle = ApiHandle();
  Future<List<Movie>>? _movies;
  // Future<List<Cast>>? _cast;

  @override
  void initState() {
    super.initState();
    _movies = api_handle.fetchData(widget.type);
  }

  void _showMovieDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
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
                    child: GestureDetector(
                      onTap: () {
                        _showMovieDetails(context, movie,);
                      },
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
