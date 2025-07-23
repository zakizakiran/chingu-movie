import 'package:get/get.dart';

import '../controllers/admin_navigation_controller.dart';

class AdminNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminNavigationController>(
      () => AdminNavigationController(),
    );
  }
}
