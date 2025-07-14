import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:get/get.dart';

import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map? ?? {};

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
          child: Column(
            children: [
              Center(
                child:
                    args['movieTitle'] != null
                        ? Text(args['movieTitle'], style: AppTextStyles.label)
                        : Text('Unknown Movie', style: AppTextStyles.label),
              ),
              SizedBox(height: 16.h),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/jumbo-poster.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.darkGrey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Thursday, June 26th, 2025",
                            style: AppTextStyles.smallText,
                          ),
                          Text("Studio 1", style: AppTextStyles.smallText),
                          SizedBox(height: 8.h),
                          args['showtime'] != null
                              ? Text(
                                args['showtime'],
                                style: AppTextStyles.body,
                              )
                              : Text(
                                'Unknown Showtime',
                                style: AppTextStyles.body,
                              ),
                          SizedBox(height: 10.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: QrImageView(
                              data: 'movie data',
                              version: QrVersions.auto,
                              size: 250.0,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // Text("2 Seats", style: AppTextStyles.smallText,),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 6.w,
                            runSpacing: 6.h,
                            children:
                                (args["selectedSeats"] as List?)?.map<Widget>((
                                  seat,
                                ) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryDark.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                    child: Text(
                                      seat.toString(),
                                      style: AppTextStyles.smallText.copyWith(
                                        color: AppColors.primaryDark,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                          SizedBox(height: 12.h),
                          args['totalPrice'] != null
                              ? Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp',
                                  decimalDigits: 0,
                                ).format(args['totalPrice']),
                                style: AppTextStyles.label,
                              )
                              : Text(
                                "Total Price: Unknown",
                                style: AppTextStyles.label,
                              ),
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
