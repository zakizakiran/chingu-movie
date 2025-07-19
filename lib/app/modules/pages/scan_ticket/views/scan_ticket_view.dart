import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/scan_ticket_controller.dart';

class ScanTicketView extends GetView<ScanTicketController> {
  const ScanTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Ticket', style: AppTextStyles.label),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: controller.cameraController,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final code = barcodes.first.rawValue;
                  if (code != null && !controller.isScanned.value) {
                    controller.isScanned.value = true;
                    controller.result.value = code;
                    debugPrint('Scanned QR: $code');
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.result.value.isEmpty
                        ? 'Scan a QR Code'
                        : 'Result: ${controller.result.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: () {
                      controller.toggleCamera();
                    },
                    icon: const Icon(Icons.cameraswitch),
                    label: Text(
                      controller.isFrontCamera.value
                          ? 'Kamera Depan'
                          : 'Kamera Belakang',
                    ),
                  ),
                ),
                Obx(
                  () =>
                      controller.isScanned.value
                          ? TextButton(
                            onPressed: () {
                              controller.resetScan();
                            },
                            child: const Text('Scan Lagi'),
                          )
                          : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
