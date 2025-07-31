import 'package:get/get.dart';

class TicketController extends GetxController {
  get movieTitle => Get.arguments?['movieTitle'] ?? 'Unknown Movie';

  final count = 0.obs;

  void increment() => count.value++;
}
