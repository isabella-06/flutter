import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/movies_controller.dart'; 
import 'package:movies/models/serie.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actors.dart';

class SeriesDetailsScreen extends StatelessWidget {
  const SeriesDetailsScreen({super.key, required this.serie});
  final Serie serie;

  @override
  Widget build(BuildContext context) {
    if (serie.overview == 'Loading...') {
      return FutureBuilder<Serie?>(
        future: ApiService.getSeriesDetails(serie.id),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return _buildContent(snapshot.data!);
          } else {
            return _buildContent(serie);
          }
        },
      );
    } else {
      return _buildContent(serie);
    }
  }

  Widget _buildContent(Serie displayedSerie) {
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
                    const Text('TV Series Detail', style: TextStyle(fontSize: 20)),
                    Tooltip(
                      message: 'Save this series',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchListSeries(displayedSerie);
                        },
                        icon: Obx(
                          () => Get.find<MoviesController>().isInWatchListSeries(displayedSerie)
                              ? const Icon(Icons.bookmark, color: Colors.white, size: 33)
                              : const Icon(Icons.bookmark_outline, color: Colors.white, size: 33),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    Image.network(
                      Api.imageBaseUrl + displayedSerie.backdropPath,
                      width: Get.width, height: 250, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey),
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return FadeShimmer(width: Get.width, height: 250, highlightColor: const Color(0xff22272f), baseColor: const Color(0xff20252d));
                      },
                    ),
                    Positioned(
                      bottom: 0, left: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${displayedSerie.posterPath}',
                          width: 110, height: 140, fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255, left: 150,
                      child: SizedBox(
                        width: 200,
                        child: Text(displayedSerie.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, maxLines: 2),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: Colors.white,
                        tabs: [Tab(text: 'About'), Tab(text: 'Cast')],
                      ),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              displayedSerie.overview.isEmpty || displayedSerie.overview == 'Loading...' 
                                ? 'No overview available.' 
                                : displayedSerie.overview,
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ),
                          FutureBuilder<List<Actor>?>(
                            future: ApiService.getSeriesCast(displayedSerie.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return GridView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.7,
                                    mainAxisSpacing: 10, crossAxisSpacing: 10),
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
                                                errorBuilder: (_,__,___) => Icon(Icons.person),
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
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}