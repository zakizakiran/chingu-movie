import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                                if (code != null &&
                                    !controller.isScanned.value) {
                                  controller.isScanned.value = true;
                                  controller.result.value = code;
                                  debugPrint('Scanned QR: $code');

                                  // Tambahan: fetch detail ticket
                                  controller.fetchTicketAndMovie(code);
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
                    () =>
                        controller.isScanned.value
                            ? TextButton(
                              onPressed: () {
                                controller.resetScan();
                              },
                              child: const Text('Scan Again'),
                            )
                            : const SizedBox(),
                  ),

                  Obx(() {
                    if (controller.isScanned.value) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child:
                            controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : validCard(
                                  ticketCode: controller.result.value,
                                  movieTitle: controller.movieTitle.value,
                                  movieStudio: controller.movieStudio.value,
                                  movieShowtime: controller.movieShowtime.value,
                                  imagePath: controller.imagePath.value,
                                ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget validCard({
    String? ticketCode,
    String? movieTitle,
    String? movieStudio,
    String? movieShowtime,
    String? imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("#${ticketCode ?? "XXXX"}", style: AppTextStyles.label),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: HexColor("#daf7ea"),
                border: Border.all(color: AppColors.success),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.w),
                child: Text(
                  "Valid",
                  style: AppTextStyles.smallTextBold.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      movieTitle ?? "Unknown Title",
                      style: AppTextStyles.label,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      movieStudio ?? "Not available",
                      style: AppTextStyles.smallText,
                    ),
                    Text(
                      movieShowtime ?? "XX - XX",
                      style: AppTextStyles.smallText,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
