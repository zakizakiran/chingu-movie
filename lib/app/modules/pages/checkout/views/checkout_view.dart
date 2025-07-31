import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Checkout', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/jumbo-poster.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "assets/images/logo.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    args["movieTitle"] ?? "Unknown Movie",
                                    style: AppTextStyles.label.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    controller.todayFormatted,
                                    style: AppTextStyles.smallText,
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    args["showtime"],
                                    style: AppTextStyles.smallText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transaction Details",
                              style: AppTextStyles.label,
                            ),
                            SizedBox(height: 10.h),
                            transactionDetailsText(
                              label: "Seats",
                              value: args["selectedSeats"].join(", "),
                            ),
                            transactionDetailsText(
                              label: "${args["selectedSeats"].length} Tickets",
                              value:
                                  "${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(args["price"])} x${args["selectedSeats"].length}",
                            ),
                            transactionDetailsText(
                              label: "Service Fee",
                              value:
                                  "${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(controller.servicesFee)} x${args["selectedSeats"].length}",
                            ),
                            Text(
                              "For support our future services",
                              style: AppTextStyles.hintText.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            transactionDetailsText(
                              label: "Total",
                              value: NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(controller.totalFee),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Obx(
                  () => CustomButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () async {
                              await controller.saveTicket();

                              Get.toNamed(
                                "/success-checkout",
                                arguments: {
                                  "selectedSeats": controller.selectedSeats,
                                  "movieTitle": controller.movieTitle,
                                  "showtime": controller.showTime,
                                  "price": controller.pricePerSeat,
                                  "totalPrice": controller.totalFee,
                                },
                              );
                            },

                    borderRadius: 20.r,
                    backgroundColor:
                        controller.isLoading.value
                            // ignore: deprecated_member_use
                            ? AppColors.primary.withOpacity(0.5)
                            : AppColors.primary,
                    text:
                        controller.isLoading.value
                            ? 'Processing...'
                            : 'Checkout',
                    height: 65.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionDetailsText({String? label, String? value}) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? "Unknown",
            style: AppTextStyles.smallText.copyWith(fontSize: 14),
          ),
          Text(
            value ?? "XX",
            style: AppTextStyles.smallTextBold.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
