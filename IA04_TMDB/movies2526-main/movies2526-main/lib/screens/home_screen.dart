import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/main_controller.dart'; 
import 'package:movies/controllers/movies_controller.dart'; 
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/screens/details_screen_actors.dart';
import 'package:movies/screens/details_screen_movies.dart';
import 'package:movies/screens/details_screen_series.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/widgets/top_actor_item.dart';
import 'package:movies/widgets/top_movie_item.dart';
import 'package:movies/widgets/top_series_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MainController controller = Get.put(MainController());
  final SearchController1 searchController = Get.put(SearchController1());
  final MoviesController moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies & Actors App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMenuChip(Category.movies, "Movies"),
                    const SizedBox(width: 10),
                    _buildMenuChip(Category.series, "Series"),
                    const SizedBox(width: 10),
                    _buildMenuChip(Category.actors, "Actors"),
                  ],
                ),
                const SizedBox(height: 20),

                Obx(() => controller.currentCategory.value == Category.actors 
                  ? Column(children: [
                      SearchBox(
                        onSumbit: () {
                          String search = Get.find<SearchController1>().searchController.text;
                          Get.find<SearchController1>().searchController.text = '';
                          Get.find<SearchController1>().search(search);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      const SizedBox(height: 20),
                    ]) 
                  : const SizedBox()),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.currentCategory.value == Category.actors){ return _buildActorsGrid();}
                  else if (controller.currentCategory.value == Category.movies){ return _buildMoviesGrid();}
                  else {return _buildSeriesGrid();}
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuChip(Category category, String label) {
    return Expanded(
      child: Obx(() {
        bool isSelected = controller.currentCategory.value == category;
        return GestureDetector(
          onTap: () => controller.switchCategory(category),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3A3F47) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3A3F47)),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActorsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Actors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: controller.popularActors.take(5).length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemBuilder: (_, index) => TopActorItem(actor: controller.popularActors[index], index: index + 1),
          ),
        ),
        const SizedBox(height: 30),
        const Text('Other Popular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.7),
          itemCount: controller.popularActors.skip(5).length,
          itemBuilder: (_, index) => _buildGridItem(
            name: controller.popularActors[index + 5].name,
            imagePath: controller.popularActors[index + 5].profilePath,
            onTap: () => Get.to(() => ActorDetailsScreen(actor: controller.popularActors[index + 5])),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Movies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: controller.popularMovies.take(5).length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemBuilder: (_, index) => TopMovieItem(
              movie: controller.popularMovies[index],
              index: index + 1,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Other Popular Section
        const Text('Other Popular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.7),
          itemCount: controller.popularMovies.skip(5).length,
          itemBuilder: (_, index) {
            final movie = controller.popularMovies[index + 5];
            return _buildGridItem(
              name: movie.title,
              imagePath: movie.posterPath,
              onTap: () => Get.to(() => MovieDetailsScreen(movie: movie)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSeriesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Series', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: controller.popularSeries.take(5).length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemBuilder: (_, index) => TopSerieItem(
              serie: controller.popularSeries[index],
              index: index + 1,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Other Popular Section
        const Text('Other Popular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.7),
          itemCount: controller.popularSeries.skip(5).length,
          itemBuilder: (_, index) {
            final serie = controller.popularSeries[index + 5];
            return _buildGridItem(
              name: serie.name,
              imagePath: serie.posterPath,
              onTap: () => Get.to(() => SeriesDetailsScreen(serie: serie)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGridItem({required String name, required String imagePath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + imagePath,
                fit: BoxFit.cover, width: double.infinity,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const FadeShimmer(width: double.infinity, height: double.infinity, highlightColor: Color(0xff22272f), baseColor: Color(0xff20252d));
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}