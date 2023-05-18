import 'package:flutter/material.dart';
import 'package:movieapp/const/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../data/api_handle.dart';
import '../models/video.dart';

class WatchVideo extends StatefulWidget {
  final int movieId;
  const WatchVideo({super.key, required this.movieId});

  @override
  State<WatchVideo> createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  final api_handle = ApiHandle();
  Future<List<Video>>? _video;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _video = api_handle.getMovieVideo(widget.movieId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _video,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Video video = snapshot.data![0];
          _controller = YoutubePlayerController(
            initialVideoId: video.key,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              loop: true,
            ),
          );
          return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              title: Text(video.name),
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  // showVideoProgressIndicator: true,
                  // progressIndicatorColor: Colors.amber,
                ),
                builder: (context, player) {
                  return Container(
                    child: player,
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
