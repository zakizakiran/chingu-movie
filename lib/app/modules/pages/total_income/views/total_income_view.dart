import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_grafik_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/total_income_controller.dart';

class TotalIncomeView extends GetView<TotalIncomeController> {
  const TotalIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Total Income', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Obx(() {
                  // Ambil data berdasarkan selectedValue
                  String value = controller.selectedValue.value;

                  List<FlSpot> currentSpots;
                  Map<int, String> currentBottomLabels;
                  Map<int, String> currentLeftLabels;

                  switch (value) {
                    case 'Daily':
                      currentSpots = controller.dailySpots;
                      currentBottomLabels = controller.dailyBottomLabels;
                      currentLeftLabels = controller.dailyLeftLabels;
                      break;
                    case 'Weekly':
                      currentSpots = controller.weeklySpots;
                      currentBottomLabels = controller.weeklyBottomLabels;
                      currentLeftLabels = controller.weeklyLeftLabels;
                      break;
                    case 'Monthly':
                      currentSpots = controller.monthlySpots;
                      currentBottomLabels = controller.monthlyBottomLabels;
                      currentLeftLabels = controller.monthlyLeftLabels;
                      break;
                    case 'Yearly':
                      currentSpots = controller.yearlySpots;
                      currentBottomLabels = controller.yearlyBottomLabels;
                      currentLeftLabels = controller.yearlyLeftLabels;
                      break;
                    default:
                      currentSpots = [];
                      currentBottomLabels = {};
                      currentLeftLabels = {};
                  }

                  return CustomGrafikContainer(
                    selectedValue: controller.selectedValue,
                    items: ['Daily', 'Weekly', 'Monthly', 'Yearly'],
                    onChanged: (value) {
                      controller.selectedValue.value = value!;
                    },
                    controller: controller,
                    chartSpots: currentSpots,
                    bottomLabels: currentBottomLabels,
                    leftLabels: currentLeftLabels,
                  );
                }),

                SizedBox(height: 20.h),
                ListView.builder(
                  itemCount: controller.movieTitle.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: movieCard(
                        index: (index + 1).toString(),
                        movieTitle: controller.movieTitle[index],
                        totalTicket: controller.movieTicket[index],
                        totalIncome: controller.movieIncome[index],
                        assetImage: AssetImage(controller.movieImage[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget movieCard({
    String? movieTitle,
    String? totalTicket,
    String? totalIncome,
    String? index,
    AssetImage? assetImage,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "#${index ?? 0}",
              style: AppTextStyles.smallTextBold.copyWith(
                color: AppColors.lightGrey,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 80.h,
              width: 60.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      assetImage ??
                      const AssetImage('assets/images/jumbo-poster.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              height: 80.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movieTitle ?? "Unknown Title",
                    style: AppTextStyles.cardTitle,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Ticket Sold Out",
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.darkGrey,
                      fontSize: 10,
                    ),
                  ),
                  Text(totalTicket ?? "0", style: AppTextStyles.label),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 80.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Income",
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.darkGrey,
                      fontSize: 10,
                    ),
                  ),
                  Text(totalIncome ?? "-", style: AppTextStyles.label),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
