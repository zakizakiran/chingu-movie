import 'package:get/get.dart';

import '../controllers/ticket_oder_controller.dart';

class TicketOderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketOrderController>(() => TicketOrderController());
  }
}
