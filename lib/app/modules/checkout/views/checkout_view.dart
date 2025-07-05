import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: AppTextStyles.label),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 110.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Image.asset(
                        "assets/images/jumbo-poster.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/logo.png", height: 50.h),
                          Text(args['movieTitle'], style: AppTextStyles.label),
                          Text(
                            "Thursday, June 26th, 2025",
                            style: AppTextStyles.smallText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsetsGeometry.only(bottom: 20.h)),
                Text("Transaction Details", style: AppTextStyles.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
