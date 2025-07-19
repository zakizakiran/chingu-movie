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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
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
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Obx(
                  () => Text(
                    controller.result.value.isEmpty
                        ? 'Scan Ticket'
                        : 'Result: ${controller.result.value}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),

                Obx(
                  () => ElevatedButton.icon(
                    onPressed: () {
                      controller.toggleCamera();
                    },
                    icon: const Icon(Icons.cameraswitch),
                    label: Text(
                      controller.isFrontCamera.value
                          ? 'Front Camera'
                          : 'Rear Camera',
                    ),
                  ),
                ),

                Obx(
                  () => controller.isScanned.value
                      ? TextButton(
                          onPressed: () {
                            controller.resetScan();
                          },
                          child: const Text('Scan Again'),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
