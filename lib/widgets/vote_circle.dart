import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

class VoteCircle extends StatelessWidget {
  final double voteAverage;

  const VoteCircle({Key? key, required this.voteAverage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strokeWidth = 6.0;
    final value = voteAverage / 10.0;
    final percentage = value.clamp(0.0, 1.0);

    return Container(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percentage,
            strokeWidth: strokeWidth,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 0.5 ? Colors.green : Colors.yellow[800]!,
            ),
          ),
          Text(
            (voteAverage * 10).toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 60 / 4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
