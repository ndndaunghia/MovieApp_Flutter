import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/auth/auth_controller.dart';
import 'package:movieapp/data/database_controller.dart';

// ignore: must_be_immutable
class FavoriteMovieCard extends StatelessWidget {
  FavoriteMovieCard({
    Key? key,
    required this.id,
    required this.title,
    required this.posterPath,
  }) : super(key: key);
  int id;
  String title;

  String posterPath;
  // final authC = Get.find<AuthController>();
  final dbC = Get.find<DatabaseController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.34,
            height: screenWidth * 0.5,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(posterPath))),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: screenWidth * .46,
            height: screenWidth * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * .3,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          dbC.deleteMovie(authC.getUserId(), id);
                          dbC.deleteMovieInList(id);
                        },
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
