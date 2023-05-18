import 'package:flutter/material.dart';
import '../data/api_handle.dart';
import '../models/movie.dart';
import 'movie_detail.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final api_handle = ApiHandle();
  Future<List<Movie>>? _movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movies = api_handle.getTrendingMovie();
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Trending Movies',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Movie>>(
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
                                _showMovieDetails(
                                  context,
                                  movie,
                                );
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
            ),
          ),
        ],
      ),
    );
  }
}
