import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_grafik_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/total_income_controller.dart';
import 'package:intl/intl.dart';

class TotalIncomeView extends GetView<TotalIncomeController> {
  const TotalIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TotalIncomeController>(
      init: TotalIncomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text('Total Income', style: AppTextStyles.label),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Obx(() {
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

                      return Column(
                        children: [
                          CustomGrafikContainer(
                            selectedValue: controller.selectedValue,
                            items: ['Daily', 'Weekly', 'Monthly', 'Yearly'],
                            onChanged: (value) {
                              controller.selectedValue.value = value!;
                            },
                            controller: controller,
                            chartSpots: controller.currentSpots,
                            bottomLabels: controller.currentBottomLabels,
                            leftLabels: controller.currentLeftLabels,
                          ),
                          SizedBox(height: 20.h),

                          // List movieCard berdasarkan selectedValue
                          ...List.generate(controller.currentMovies.length, (
                            index,
                          ) {
                            final movie = controller.currentMovies[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: movieCard(
                                index: (index + 1).toString(),
                                movieTitle: movie['movieTitle'],
                                totalTicket: movie['ticket'].toString(),
                                totalIncome: movie['income'].toString(),
                                assetImage: AssetImage(
                                  controller.movieImage[index],
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            Text(
              "#${index ?? 0}",
              style: AppTextStyles.smallTextBold.copyWith(
                color: AppColors.lightGrey,
              ),
            ),
            SizedBox(width: 10.w),
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
            Expanded(
              child: SizedBox(
                height: 80.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      movieTitle ?? "Unknown Title",
                      style: AppTextStyles.cardTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ticket Sold Out",
                                style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.darkGrey,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                totalTicket ?? "0",
                                style: AppTextStyles.label,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w), // jarak antar kolom
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Income",
                                style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.darkGrey,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(int.parse(totalIncome ?? "0")),
                                style: AppTextStyles.label,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
