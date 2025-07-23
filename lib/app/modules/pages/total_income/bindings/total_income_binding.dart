import 'package:get/get.dart';

import '../controllers/total_income_controller.dart';

class TotalIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TotalIncomeController>(
      () => TotalIncomeController(),
    );
  }
}
