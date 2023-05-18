import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/data/api_handle.dart';
import 'package:movieapp/models/search.dart';
import 'package:movieapp/widgets/custom_navbar.dart';

import '../models/movie.dart';
import 'movie_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  List<dynamic> _searchResults = [];
  Future<List<Search>>? search;

  Future<List<dynamic>> searchMovies(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=97d39b50c99a2fd2db9f2ed346557b45&query=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      debugPrint(decoded.toString());
      return decoded['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  _showMovieDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search',
      home: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: TextField(
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      hintText: 'Search movies...',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: searchMovies(_searchQuery),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _searchResults = snapshot.data!;
                      return ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          var movie = _searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              _showMovieDetails(
                                  context,
                                  Movie(
                                    id: movie["id"],
                                    title: movie["title"],
                                    overview: movie["overview"],
                                    posterPath: movie["poster_path"],
                                    backdropPath: movie["backdrop_path"],
                                    releaseDate: movie["release_date"],
                                    voteAverage: movie["vote_average"],
                                  ));
                            },
                            child: ListTile(
                              textColor: Colors.white,
                              title: Text(movie["title"]),
                              // title: Text(search),
                              subtitle: Text(movie["release_date"]),
                              // subtitle: Text(search[index].releaseDate),
                              leading: Image.network(
                                'https://image.tmdb.org/t/p/w92${movie["poster_path"]}',
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const Icon(Icons.movie);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
