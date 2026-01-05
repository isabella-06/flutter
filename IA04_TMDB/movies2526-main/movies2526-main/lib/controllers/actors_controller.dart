import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs;
  var popularActors = <Actor>[].obs;

  @override
  void onInit() async {
    super.onInit();
    fetchPopularActors();
  }

  void fetchPopularActors() async {
    isLoading.value = true;
    var result = await ApiService.getPopularActors();
    if (result != null) {
      popularActors.value = result;
    }
    isLoading.value = false;
  }
}