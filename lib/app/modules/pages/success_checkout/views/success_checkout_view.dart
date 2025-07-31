import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/success_checkout_controller.dart';

class SuccessCheckoutView extends GetView<SuccessCheckoutController> {
  const SuccessCheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/animations/success.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Success Checkout',
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Thank you for your purchase!. You can pay your order on our cashier.',
                  style: AppTextStyles.smallText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                Get.offAllNamed(
                  '/bottom-navigation',
                  arguments: {'currentIndex': 1},
                );
              },
              borderRadius: 20.r,
              backgroundColor: AppColors.primary,
              text: 'View Orders',
              height: 65.h,
            ),
          ],
        ),
      ),
    );
  }
}
