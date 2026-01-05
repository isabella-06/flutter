import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/serie.dart';

/// Categories that can be displayed in the home screen
enum Category { actors, movies, series }

/// Controller that manages the home screen data and category switching
class MainController extends GetxController {
  /// Currently selected category to display
  var currentCategory = Category.movies.obs;
  /// Flag indicating if data is being loaded
  var isLoading = false.obs;

  /// List of popular actors fetched from API
  var popularActors = <Actor>[].obs;
  /// List of popular movies fetched from API
  var popularMovies = <Movie>[].obs;
  /// List of popular TV series fetched from API
  var popularSeries = <Serie>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// Switches to a different category and loads its data
  void switchCategory(Category category) {
    currentCategory.value = category;
    loadData();
  }

  /// Fetches data for the currently selected category from the API
  void loadData() async {
    isLoading.value = true;
    switch (currentCategory.value) {
      case Category.actors:
        if (popularActors.isEmpty) {
          popularActors.value = (await ApiService.getPopularActors()) ?? [];
        }
        break;
      case Category.movies:
        if (popularMovies.isEmpty) {
          popularMovies.value = (await ApiService.getTopRatedMovies()) ?? [];
        }
        break;
      case Category.series:
        if (popularSeries.isEmpty) {
          popularSeries.value = (await ApiService.getPopularSeries()) ?? [];
        }
        break;
    }
    isLoading.value = false;
  }
}