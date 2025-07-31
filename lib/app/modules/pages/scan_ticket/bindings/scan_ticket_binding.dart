import 'package:get/get.dart';

import '../controllers/scan_ticket_controller.dart';

class ScanTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanTicketController>(
      () => ScanTicketController(),
    );
  }
}
