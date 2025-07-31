import 'package:get/get.dart';

import '../controllers/edit_movie_controller.dart';

class EditMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMovieController>(
      () => EditMovieController(),
    );
  }
}
