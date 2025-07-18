import 'package:get/get.dart';

class TicketController extends GetxController {
  get movieTitle => Get.arguments?['movieTitle'] ?? 'Unknown Movie';

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
