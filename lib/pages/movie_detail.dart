import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/const/colors.dart';
import 'package:movieapp/data/database_controller.dart';
import 'package:movieapp/pages/get_video.dart';
import 'package:movieapp/pages/movie_cast.dart';
import 'package:movieapp/widgets/vote_circle.dart';
import '../auth/auth_controller.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  late Movie movie;

  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final authC = Get.find<AuthController>();
  final dbC = Get.find<DatabaseController>();
  late Movie movie;
  bool isFavorite = false;
  late DatabaseReference _favoriteRef;
  late List<Movie> _favoriteMovies;
  StreamController<List<Movie>> _moviesStreamController =
      StreamController<List<Movie>>();

  bool isFavorites(int movieId) {
    List<Movie> favoriteMovies = dbC.getIdMovie(authC.getUserId(), movieId);
    return favoriteMovies.any((movie) => movie.id == movieId);
  }

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
    _favoriteRef = FirebaseDatabase.instance
        .ref('/users/${authC.getUserId()}/favorite_movies/${movie.id}');
    _favoriteRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          isFavorite = true;
          // dbC.getStatusMovie(true);
        });
      } else {
        setState(() {
          isFavorite = false;
          // dbC.getStatusMovie(false);
        });
      }
    });
  }

  Future<void> toggleFavorite() async {
    if (isFavorite) {
      await _favoriteRef.remove();
    } else {
      await _favoriteRef.set(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.network(
              widget.movie.fullPosterPath,
              height: 310,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        // Obx(
                        //   () => InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         if (dbC.getStatusMovie.value) {
                        //           dbC.deleteMovie(authC.getUserId(), movie.id);
                        //           dbC.getStatusMovie(false);
                        //         } else {
                        //           dbC.writeDataMovie(authC.getUserId(),
                        //               movie.id, movie.title, movie.posterPath);
                        //           dbC.getStatusMovie(true);
                        //         }
                        //       });
                        //     },
                        //     // child: Icon(
                        //     //   dbC.getStatusMovie.value
                        //     //       ? Icons.favorite
                        //     //       : Icons.favorite_border,
                        //     //   color: Colors.white,
                        //     //   size: 28,
                        //     // ),

                        //     child: IconButton(
                        //       icon: Icon(isFavorite
                        //           ? Icons.favorite
                        //           : Icons.favorite_border),
                        //       onPressed: toggleFavorite,
                        //     ),
                        //   ),
                        // ),

                        Obx(
                          () {
                            bool isMovieFavorite = dbC.getStatusMovie
                                .value; // Truy xuất giá trị thực tế từ Obx
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isMovieFavorite) {
                                    // Sử dụng giá trị bool trong câu lệnh if
                                    dbC.deleteMovie(
                                        authC.getUserId(), movie.id);
                                    dbC.getStatusMovie(false);
                                    isFavorites(movie.id);
                                  } else {
                                    dbC.writeDataMovie(
                                      authC.getUserId(),
                                      movie.id,
                                      movie.title,
                                      movie.posterPath,
                                    );
                                    dbC.getStatusMovie(true);
                                    isFavorites(movie.id);
                                  }
                                });
                              },
                              child: Icon(
                                (isMovieFavorite)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                                size: 28,
                              ),
                            );
                          },
                        ),
                        // IconButton(
                        //   color: Colors.white,
                        //   icon: Icon(isFavorite
                        //       ? Icons.favorite
                        //       : Icons.favorite_border),
                        //   onPressed: toggleFavorite,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.movie.fullPosterPath,
                              height: 260,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WatchVideo(
                                      movieId: widget.movie.id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.8),
                                      spreadRadius: 4,
                                      blurRadius: 4,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text("Watch Trailer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.movie.overview,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Release Date:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.movie.releaseDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Rating:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            VoteCircle(voteAverage: widget.movie.voteAverage),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Cast',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        MovieCast(
                          movieId: widget.movie.id,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
