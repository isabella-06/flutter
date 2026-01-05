import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/screens/details_screen_movies.dart';
import 'package:movies/screens/details_screen_series.dart';

class WatchList extends StatelessWidget {
  WatchList({super.key});

  final MoviesController controller = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch List', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: Color(0xFF3A3F47),
              indicatorWeight: 4,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Movies'),
                Tab(text: 'TV Series'),
              ],
            ),
            
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () => controller.watchListMovies.isEmpty
                        ? const Center(child: Text('No movies added.'))
                        : ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemCount: controller.watchListMovies.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final movie = controller.watchListMovies[index];
                              return GestureDetector(
                                onTap: () => Get.to(() => MovieDetailsScreen(movie: movie)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        Api.imageBaseUrl + movie.posterPath,
                                        width: 80, height: 120, fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(width: 80, height: 120, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(movie.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 5),
                                          Text(movie.releaseDate, style: const TextStyle(color: Colors.grey)),
                                          const SizedBox(height: 5),
                                          Text(movie.voteAverage.toString(), style: const TextStyle(color: Colors.amber)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      onPressed: () => controller.addToWatchList(movie),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),

                  Obx(
                    () => controller.watchListSeries.isEmpty
                        ? const Center(child: Text('No series added.'))
                        : ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemCount: controller.watchListSeries.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final serie = controller.watchListSeries[index];
                              return GestureDetector(
                                onTap: () => Get.to(() => SeriesDetailsScreen(serie: serie)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        Api.imageBaseUrl + serie.posterPath,
                                        width: 80, height: 120, fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(width: 80, height: 120, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(serie.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 5),
                                          Text(serie.firstAirDate, style: const TextStyle(color: Colors.grey)),
                                          const SizedBox(height: 5),
                                          Text(serie.voteAverage.toString(), style: const TextStyle(color: Colors.amber)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      onPressed: () => controller.addToWatchListSeries(serie),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}