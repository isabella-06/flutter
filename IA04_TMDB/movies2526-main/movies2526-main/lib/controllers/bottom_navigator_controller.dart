import 'package:get/get.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/watch_list_screen.dart';

/// Controller that manages bottom navigation bar state and screen switching
class BottomNavigatorController extends GetxController {
  /// List of screens available in the navigation
  /// Index 0: HomeScreen - displays popular movies, series, and actors
  /// Index 1: SearchScreen - search for movies
  /// Index 2: WatchList - view saved movies and series
  var screens = [
    HomeScreen(),
    const SearchScreen(),
    WatchList(),
  ];
  /// Currently selected navigation tab index
  var index = 0.obs;
  
  /// Updates the current navigation index to switch screens
  void setIndex(indx) => index.value = indx;
}
