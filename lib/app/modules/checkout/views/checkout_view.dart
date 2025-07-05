import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
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
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
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
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      transactionDetails(text: "Seats", value: "F5, F6"),
                      transactionDetails(
                        text: "2 Tickets",
                        value: "Rp. 40.000 x 2",
                      ),
                      transactionDetails(
                        text: "Service Fee",
                        value: "Rp. 5.000 x 2",
                      ),
                      Text(
                        "For support our future services",
                        style: AppTextStyles.smallText,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.h)),
                      transactionDetails(text: "Total", value: "Rp. 90.000"),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsetsGeometry.only(bottom: 30.h)),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text("Payment Method", style: AppTextStyles.label),
                ),
                SizedBox(
                  height: 160.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: "QRIS",
                        onPressed: () {},
                        backgroundColor: Colors.black,
                      ),
                      CustomButton(
                        text: "E-WALLET",
                        onPressed: () {},
                        backgroundColor: Colors.black,
                      ),
                      CustomButton(
                        text: "Debit",
                        onPressed: () {},
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 30.h),
                  child: CustomButton(
                    text: "Confim",
                    onPressed: () {},
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget transactionDetails({required String text, required String value}) {
  return Padding(
    padding: EdgeInsets.only(top: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppTextStyles.body),
        Text(value, style: AppTextStyles.body,),
      ],
    ),
  );
}
