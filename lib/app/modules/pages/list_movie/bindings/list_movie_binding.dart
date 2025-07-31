import 'package:get/get.dart';

import '../controllers/list_movie_controller.dart';

class ListMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMovieController>(
      () => ListMovieController(),
    );
  }
}
