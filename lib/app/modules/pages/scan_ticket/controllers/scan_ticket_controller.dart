import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanTicketController extends GetxController {
  //TODO: Implement ScanTicketController
  final RxString result = ''.obs;
  final RxBool isScanned = false.obs;
  final RxBool isFrontCamera = false.obs;

  final MobileScannerController cameraController = MobileScannerController();

  void toggleCamera() {
    isFrontCamera.value = !isFrontCamera.value;
    cameraController.switchCamera();
  }

  void resetScan() {
    result.value = '';
    isScanned.value = false;
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  void increment() => count.value++;
}
