import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/serie.dart';
import 'package:movies/screens/details_screen_series.dart';
import 'package:movies/widgets/index_number.dart';

/// Widget that displays a single top TV series card with ranking number
/// Shows the series poster image and a ranking badge
class TopSerieItem extends StatelessWidget {
  const TopSerieItem({
    super.key,
    required this.serie,
    required this.index,
  });

  /// The TV series object to display
  final Serie serie;
  /// The ranking index of this series
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => SeriesDetailsScreen(serie: serie)),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + serie.posterPath,
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