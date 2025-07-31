import 'package:get/get.dart';

import '../controllers/success_checkout_controller.dart';

class SuccessCheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessCheckoutController>(
      () => SuccessCheckoutController(),
    );
  }
}
