import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart'; // Import this
import 'package:movies/screens/details_screen_actors.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/widgets/top_actor_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ActorsController controller = Get.put(ActorsController());
  
  // FIX: Initialize the SearchController here so SearchBox can find it
  final SearchController1 searchController = Get.put(SearchController1());
  final MoviesController moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discover Actors',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                const SizedBox(height: 24),

                // SearchBox now works because searchController is initialized above
                SearchBox(
                  onSumbit: () {
                    String search = Get.find<SearchController1>().searchController.text;
                    Get.find<SearchController1>().searchController.text = '';
                    Get.find<SearchController1>().search(search);
                    FocusManager.instance.primaryFocus?.unfocus();
                    // Note: If you have a SearchScreen, you need to navigate to it here
                  },
                ),
                
                const SizedBox(height: 34),

                // ... (Rest of your Top Actors and Popular Actors code) ...
                const Text('Top Actors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                Obx(() {
                  if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
                  return SizedBox(
                    height: 250,
                    child: ListView.separated(
                      itemCount: controller.popularActors.take(5).length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 24),
                      itemBuilder: (_, index) => TopActorItem(
                        actor: controller.popularActors[index],
                        index: index + 1,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 34),
                const Text('Other popular actors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                Obx(() {
                  if (controller.isLoading.value) return const SizedBox();
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: controller.popularActors.skip(5).length,
                    itemBuilder: (context, index) {
                      final actor = controller.popularActors[index + 5];
                      return GestureDetector(
                        onTap: () => Get.to(() => ActorDetailsScreen(actor: actor)),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
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
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}