import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/serie.dart';

/// Controller that manages the watch list for movies and TV series
/// Handles adding/removing items from the watch list and tracking watched status
class MoviesController extends GetxController {
  /// List of movies saved to the watch list
  var watchListMovies = <Movie>[].obs;

  /// Checks if a movie is already in the watch list
  bool isInWatchList(Movie movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  }

  /// Toggles a movie in the watch list (add if not present, remove if already present)
  void addToWatchList(Movie movie) {
    if (watchListMovies.any((m) => m.id == movie.id)) {
      watchListMovies.removeWhere((m) => m.id == movie.id);
      Get.snackbar('Success', 'Removed from Movie list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListMovies.add(movie);
      Get.snackbar('Success', 'Added to Movie list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }

  /// List of TV series saved to the watch list
  var watchListSeries = <Serie>[].obs;

  /// Checks if a series is already in the watch list
  bool isInWatchListSeries(Serie serie) {
    return watchListSeries.any((s) => s.id == serie.id);
  }

  /// Toggles a series in the watch list (add if not present, remove if already present)
  void addToWatchListSeries(Serie serie) {
    if (watchListSeries.any((s) => s.id == serie.id)) {
      watchListSeries.removeWhere((s) => s.id == serie.id);
      Get.snackbar('Success', 'Removed from Series list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListSeries.add(serie);
      Get.snackbar('Success', 'Added to Series list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}