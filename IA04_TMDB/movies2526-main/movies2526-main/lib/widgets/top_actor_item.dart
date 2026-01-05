import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actors.dart';

class TopActorItem extends StatelessWidget {
  const TopActorItem({
    super.key,
    required this.actor,
    required this.index,
  });

  final Actor actor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            ActorDetailsScreen(actor: actor),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + actor.profilePath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 180,
                ),
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
        // Rank Number (1, 2, 3...)
        Positioned(
          bottom: 0,
          left: 0,
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xff0296E5),
              fontSize: 100, // Large text for the "Index" look
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 5.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(-2, -2),
                  blurRadius: 5.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}