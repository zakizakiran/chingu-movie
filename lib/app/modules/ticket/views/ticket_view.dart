import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:get/get.dart';

import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map? ?? {};

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Ticket', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 16.w,
            vertical: 30.h,
          ),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/jumbo-poster.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Thursday, June 26th, 2025",
                            style: AppTextStyles.smallText,
                          ),
                          Text("Studio 1", style: AppTextStyles.smallText),
                          Text(
                            "12.00 - 14.30,",
                            style: AppTextStyles.smallText,
                          ),
                          SizedBox(height: 10.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: QrImageView(
                              data: 'movie data',
                              version: QrVersions.auto,
                              size: 250.0,
                              backgroundColor: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // Text("2 Seats", style: AppTextStyles.smallText,),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 6.w,
                            runSpacing: 6.h,
                            children:
                                (args["selectedSeats"] as List<String>)
                                    .map(
                                      (seat) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryDark.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primaryDark,
                                          ),
                                        ),
                                        child: Text(
                                          seat,
                                          style: AppTextStyles.smallText
                                              .copyWith(
                                                color: AppColors.primaryDark,
                                                fontSize: 12.sp,
                                              ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                          SizedBox(height: 5.h),
                          Text("Rp. 90.000", 
                          style: AppTextStyles.label),
                        ],
                      ),
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
}
