import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';

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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Income",
                                      style: AppTextStyles.smallText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        "Rp. ${controller.income.value}",
                                        style: AppTextStyles.loginTitle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),

                                    SizedBox(height: 4.h),
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
                                          style: AppTextStyles.smallText
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                IconButton(
                                  icon: Icon(
                                    Icons.qr_code_scanner,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Get.toNamed("/scan-ticket");
                                  },
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
                          child: Obx(
                            () => Row(
                              children: [
                                ...List.generate(
                                  min(
                                    controller.title.length,
                                    min(
                                      controller.value.length,
                                      controller.information.length,
                                    ),
                                  ),
                                  (index) => Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: card(
                                      title: controller.title[index],
                                      value: controller.value[index],
                                      information:
                                          controller.information[index],
                                      icon: icon[index],
                                      onTap: () {
                                        if (index == 1) {
                                          Get.toNamed('/list-movie');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: cardInsertMovie(
                                    onTap: () => Get.toNamed('/input-movie'),
                                  ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
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
                        SizedBox(height: 10.h),
                        Divider(color: Colors.grey, thickness: 1, height: 1),
                        SizedBox(height: 10.h),
                        Obx(
                          () => SizedBox(
                            width: 300,
                            height: 250,
                            child: DonutChart(
                              labels: controller.movieTitle,
                              values: controller.totalTicket,
                              colors: List.generate(
                                controller.movieTitle.length,
                                (_) => getRandomColor(),
                              ),
                            ),
                          ),
                        ),

                        Divider(color: Colors.grey, thickness: 1, height: 1),
                        Obx(
                          () => SizedBox(
                            height: 100.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 16.w),
                              child: Row(
                                children: List.generate(
                                  controller.movieTitle.length,
                                  (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 30.w),
                                      child: totalTicketSoldOut(
                                        movieTitle:
                                            controller.movieTitle[index],
                                        totalTicket:
                                            controller.totalTicket.isNotEmpty
                                                ? (controller
                                                            .totalTicket
                                                            .isNotEmpty &&
                                                        index <
                                                            controller
                                                                .totalTicket
                                                                .length
                                                    ? controller
                                                        .totalTicket[index]
                                                    : 0)
                                                : 0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
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

  Widget card({
    String? title,
    String? value,
    String? information,
    Icon? icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
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
      ),
    );
  }
}

Widget cardInsertMovie({VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, size: 40, color: AppColors.primary),
            SizedBox(height: 10.h),
            Text(
              "Insert Movie",
              style: AppTextStyles.smallTextBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

Widget totalTicketSoldOut({String? movieTitle, double? totalTicket}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movieTitle ?? "Unknown Title",
            style: AppTextStyles.smallTextBold.copyWith(color: Colors.grey),
          ),
          Text(
            totalTicket?.toInt().toString() ?? "0",
            style: AppTextStyles.label,
          ),
          Text(
            "Tickets",
            style: AppTextStyles.smallTextBold.copyWith(color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}
