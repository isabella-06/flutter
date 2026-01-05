import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen_movies.dart'; // Import the new screen

class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({super.key, required this.actor});
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Keep Header, Image, and Bio sections exactly as before) ...
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        actor.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    Api.imageBaseUrl + actor.profilePath,
                    height: 300, width: 200, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Biography', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    FutureBuilder<Actor?>(
                      future: ApiService.getActorDetails(actor.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            snapshot.data!.biography.isNotEmpty ? snapshot.data!.biography : "No biography available.",
                            style: const TextStyle(color: Colors.grey, height: 1.5),
                          );
                        }
                        return const FadeShimmer(width: double.infinity, height: 100, radius: 8, highlightColor: Color(0xffE0E0E0), baseColor: Color(0xffF5F5F5));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- KNOWN FOR SECTION (UPDATED) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text('Known For', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),
              
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Movie>?>(
                  future: ApiService.getActorMovies(actor.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final movie = snapshot.data![index];
                          return GestureDetector(
                            // CLICKING A MOVIE NOW GOES TO MOVIE DETAILS SCREEN
                            onTap: () {
                              Get.to(() => MovieDetailsScreen(movie: movie));
                            },
                            child: SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                      height: 150, width: 100, fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(height: 150, width: 100, color: Colors.grey, child: const Icon(Icons.movie)),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(movie.title, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}