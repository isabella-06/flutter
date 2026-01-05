import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

/// Controller that manages popular actors data
class ActorsController extends GetxController {
  /// Flag indicating if actors data is currently being loaded
  var isLoading = false.obs;
  /// List of popular actors fetched from the API
  var popularActors = <Actor>[].obs;

  @override
  void onInit() async {
    super.onInit();
    /// Fetch popular actors when the controller is initialized
    fetchPopularActors();
  }

  /// Fetches the list of popular actors from the API
  void fetchPopularActors() async {
    isLoading.value = true;
    var result = await ApiService.getPopularActors();
    if (result != null) {
      popularActors.value = result;
    }
    isLoading.value = false;
  }
}