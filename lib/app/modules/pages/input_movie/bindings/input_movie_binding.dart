import 'package:get/get.dart';

import '../controllers/input_movie_controller.dart';

class InputMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputMovieController>(
      () => InputMovieController(),
    );
  }
}
