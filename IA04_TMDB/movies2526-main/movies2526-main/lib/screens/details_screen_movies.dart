import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/movies_controller.dart'; 
import 'package:movies/models/movie.dart';
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actors.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    if (movie.overview.isEmpty || movie.backdropPath.isEmpty || movie.overview == 'Loading...') {
      return FutureBuilder<Movie?>(
        future: ApiService.getMovieDetails(movie.id),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return _buildContent(snapshot.data!);
          } else {
            return _buildContent(movie, isLoading: true);
          }
        },
      );
    } else {
      return _buildContent(movie);
    }
  }

  Widget _buildContent(Movie displayedMovie, {bool isLoading = false}) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                    const Text('Movie Detail', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
                     Tooltip(
                      message: 'Save this movie',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                           Get.find<MoviesController>().addToWatchList(displayedMovie);
                        },
                        icon: Obx(() => Get.find<MoviesController>().isInWatchList(displayedMovie)
                              ? const Icon(Icons.bookmark, color: Colors.white, size: 33)
                              : const Icon(Icons.bookmark_outline, color: Colors.white, size: 33),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    displayedMovie.backdropPath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        child: Image.network(
                          Api.imageBaseUrl + displayedMovie.backdropPath,
                          width: Get.width, height: 250, fit: BoxFit.cover,
                          loadingBuilder: (_, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return FadeShimmer(width: Get.width, height: 250, highlightColor: const Color(0xff22272f), baseColor: const Color(0xff20252d));
                          },
                          errorBuilder: (_, __, ___) => Container(color: Colors.grey, height: 250, child: const Icon(Icons.broken_image)),
                        ),
                      )
                    : Container(height: 250, color: Colors.grey[800], child: const Center(child: Icon(Icons.movie, size: 50, color: Colors.white))),
                    
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${displayedMovie.posterPath}',
                            width: 110, height: 140, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(width: 110, height: 140, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255, left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(displayedMovie.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                    children: [
                      const TabBar(
                        indicatorColor: Color(0xFF3A3F47),
                        tabs: [Tab(text: 'About'), Tab(text: 'Reviews'), Tab(text: 'Cast')],
                      ),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          isLoading 
                            ? const Center(child: CircularProgressIndicator()) 
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  displayedMovie.overview.isNotEmpty ? displayedMovie.overview : "No overview available.",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                ),
                              ),
                          FutureBuilder<List<Review>?>(
                            future: ApiService.getMovieReviews(displayedMovie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index) => ListTile(
                                    title: Text(snapshot.data![index].author),
                                    subtitle: Text(snapshot.data![index].comment, maxLines: 3),
                                  ),
                                );
                              }
                              return const Center(child: Text("No reviews found"));
                            },
                          ),
                          FutureBuilder<List<Actor>?>(
                            future: ApiService.getMovieCast(displayedMovie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return GridView.builder(
                                  padding: const EdgeInsets.only(top: 20),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final actor = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () => Get.to(() => ActorDetailsScreen(actor: actor)),
                                      child: Column(children: [
                                        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(Api.imageBaseUrl + actor.profilePath, fit: BoxFit.cover, errorBuilder: (_,__,___)=>Icon(Icons.person)))),
                                        Text(actor.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ]),
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