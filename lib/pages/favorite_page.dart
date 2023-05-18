import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/data/database_controller.dart';
import '../auth/auth_controller.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final DatabaseController dbC = Get.find();
  final AuthController authC = Get.find();
  List<Widget> movieList = [];

  void fetchData() async {
    DatabaseReference movieRef = FirebaseDatabase.instance
        .reference()
        .child('Users/${authC.getUserId()}');
    DatabaseEvent movieEvent = await movieRef.once();
    DataSnapshot movieSnapshot = movieEvent.snapshot;
    if (movieSnapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> movieData = movieSnapshot.value as Map<dynamic, dynamic>;
      List<Widget> movieTiles = [];

      movieData.forEach((userId, movieData) {
        final movie = movieData as Map<dynamic, dynamic>;

        movieTiles.add(
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white30,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${movie['posterPath']}"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    movie['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                  IconButton(
                    onPressed: () {
                      int movieId = movie['movieId'];
                      dbC.deleteMovieInList(movieId);
                      dbC.deleteMovie(authC.getUserId(), movieId);
                      setState(() {
                        movieList.removeWhere((widget) {
                          final movie = widget as ListTile;
                          return movie.key == Key(movieId.toString());
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

      setState(() {
        movieList = movieTiles;
      });
    } else {
      print('No data available.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return movieList[index];
        },
      ),
    );
  }
}
