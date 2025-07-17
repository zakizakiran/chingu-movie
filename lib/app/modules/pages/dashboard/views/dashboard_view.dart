import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Icon> icon = [
      Icon(Icons.calendar_month, size: 12),
      Icon(Icons.check_circle, size: 12),
      Icon(Icons.check_circle, size: 12),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Dashboard',
          style: AppTextStyles.label.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 260.h,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170.h,
                      color: AppColors.primary,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Income",
                              style: AppTextStyles.smallText.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Rp. ${controller.income ?? "0"}",
                              style: AppTextStyles.loginTitle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  controller.date ?? "MM/YY",
                                  style: AppTextStyles.smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120.h,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 120.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: List.generate(controller.title.length, (
                              index,
                            ) {
                              return Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: card(
                                  title: controller.title[index],
                                  value: controller.value[index],
                                  information: controller.information[index],
                                  icon: icon[index],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ticket Overview",
                          style: AppTextStyles.smallTextBold,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          color: Colors.grey, 
                          thickness: 1, 
                          height: 1, 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card({String? title, String? value, String? information, Icon? icon}) {
    return Row(
      children: [
        Container(
          width: 160.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "Unknown Title",
                  style: AppTextStyles.smallText.copyWith(fontSize: 14),
                ),
                SizedBox(height: 5.h),
                Text(
                  value ?? "0",
                  style: AppTextStyles.label.copyWith(fontSize: 25),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ?? Icon(Icons.calendar_month, size: 12),
                    SizedBox(width: 5.w),
                    Text(
                      information ?? "-",
                      style: AppTextStyles.smallText.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
