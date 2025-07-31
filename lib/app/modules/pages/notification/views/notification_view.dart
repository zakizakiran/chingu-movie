import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Notification', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Obx(
            () => Column(
              children:
                  controller.notifications.map((notif) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: notificationCard(
                        title: notif['movieTitle'],
                        time: notif['showtimeMovie'],
                        status: 'Already paid',
                        date: notif['movieDate'],
                        icon: Icons.check_circle_outline,
                        iconColor: AppColors.primary,
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationCard({
    String? title,
    String? time,
    String? date,
    String? status,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // bayangan halus
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (iconColor ?? Colors.grey).withOpacity(0.1),
            ),
            child: Icon(
              icon ?? Icons.notifications,
              color: iconColor ?? Colors.grey,
              size: 28.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'No Title',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(time ?? '-', style: AppTextStyles.smallText),
                SizedBox(height: 2.h),
                Text(date ?? '-', style: AppTextStyles.smallText),
                SizedBox(height: 2.h),
                Text(
                  "Status: ${status ?? 'Unknown'}",
                  style: AppTextStyles.smallText.copyWith(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
