import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/tickets_controller.dart';

class TicketsView extends GetView<TicketsController> {
  const TicketsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets', style: AppTextStyles.label),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Image.asset(
                      "assets/images/jumbo-poster.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 300.w,
                    height: 360.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(2, 4), // X: ke kanan, Y: ke bawah
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 10.h)),
                          Text(
                            "Thursday, June 26th, 2025",
                            style: AppTextStyles.smallText,
                          ),
                          Text("12.00 - 14.30", style: AppTextStyles.smallText),
                          Padding(padding: EdgeInsets.only(bottom: 20.h)),
                          Container(
                            height: 200.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 20.h)),
                          Text("2 seats", style: AppTextStyles.smallText),
                          Text("Rp. 90.000", style: AppTextStyles.label),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
