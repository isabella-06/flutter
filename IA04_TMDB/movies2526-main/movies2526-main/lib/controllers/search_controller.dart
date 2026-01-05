import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';

/// Controller that manages movie search functionality
class SearchController1 extends GetxController {
  /// Text controller for the search input field
  TextEditingController searchController = TextEditingController();
  /// Stores the current search query text
  var searchText = ''.obs;
  /// List of movies found from the search query
  var foundedMovies = <Movie>[].obs;
  /// Flag indicating if a search is currently in progress
  var isLoading = false.obs;
  
  /// Updates the search text state
  void setSearchText(text) => searchText.value = text;
  
  /// Performs a search query to find movies matching the given query string
  void search(String query) async {
    isLoading.value = true;
    foundedMovies.value = (await ApiService.getSearchedMovies(query)) ?? [];
    isLoading.value = false;
  }
}
