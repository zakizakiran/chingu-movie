import 'package:get/get.dart';

import '../controllers/pages_splash_controller.dart';

class PagesSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PagesSplashController());
  }
}
