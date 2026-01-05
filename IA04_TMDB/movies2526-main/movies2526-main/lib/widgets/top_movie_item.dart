import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen_movies.dart';
import 'package:movies/widgets/index_number.dart';

/// Widget that displays a single top movie card with ranking number
/// Shows the movie poster image and a ranking badge
class TopMovieItem extends StatelessWidget {
  const TopMovieItem({
    super.key,
    required this.movie,
    required this.index,
  });

  /// The movie object to display
  final Movie movie;
  /// The ranking index of this movie
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => MovieDetailsScreen(movie: movie)),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + movie.posterPath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 180),
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index),
        )
      ],
    );
  }
}