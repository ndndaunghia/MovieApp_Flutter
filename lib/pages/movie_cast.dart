import 'package:flutter/material.dart';
import '../data/api_handle.dart';
import '../models/cast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCast extends StatefulWidget {
  final int movieId;
  const MovieCast({super.key, required this.movieId});

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  final api_handle = ApiHandle();
  Future<List<Cast>>? _cast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cast = api_handle.getMovieCredit(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cast>>(
        future: _cast,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshot.data!
                    .map(
                      (cast) => Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                    imageUrl: cast.fullProfilePath,
                                    height: 160,
                                    width: 100,
                                    fit: BoxFit.cover),
                                // child: Image.network(
                                //   cast.fullProfilePath,
                                //   // 'https://image.tmdb.org/t/p/w200/6X2YjjYcs8XyZRDmJAHNDlls7L4.jpg',
                                //   height: 160,
                                //   width: 100,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                cast.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cast.character,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const CircularProgressIndicator();
        });
  }
}
