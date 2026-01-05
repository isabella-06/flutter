import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/movies_controller.dart'; // Import this
import 'package:movies/models/movie.dart';
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actors.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Movie Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    // FIX: Restore the Save/Bookmark Button
                    Tooltip(
                      message: 'Save this movie to your watch list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(movie);
                        },
                        icon: Obx(
                          () => Get.find<MoviesController>().isInWatchList(movie)
                              ? const Icon(
                                  Icons.bookmark,
                                  color: Colors.white,
                                  size: 33,
                                )
                              : const Icon(
                                  Icons.bookmark_outline,
                                  color: Colors.white,
                                  size: 33,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // ... (The rest of the UI code: Image, Tabs, Cast, etc. remains the same)
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        Api.imageBaseUrl + movie.backdropPath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 250),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(0xFF3A3F47),
                          tabs: [
                            Tab(text: 'About Movie'),
                            Tab(text: 'Reviews'),
                            Tab(text: 'Cast'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              movie.overview,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                            ),
                          ),
                          FutureBuilder<List<Review>?>(
                            future: ApiService.getMovieReviews(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isEmpty
                                    ? const Center(child: Text('No reviews'))
                                    : ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (_, index) => ListTile(
                                          title: Text(snapshot.data![index].author),
                                          subtitle: Text(snapshot.data![index].comment, maxLines: 3),
                                        ),
                                      );
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          FutureBuilder<List<Actor>?>(
                            future: ApiService.getMovieCast(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return GridView.builder(
                                  padding: const EdgeInsets.only(top: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final actor = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () => Get.to(() => ActorDetailsScreen(actor: actor)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                Api.imageBaseUrl + actor.profilePath,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => const Icon(Icons.person),
                                              ),
                                            ),
                                          ),
                                          Text(actor.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(child: Text('No cast info available'));
                            },
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}