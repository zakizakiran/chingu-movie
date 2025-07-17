import 'package:chingu_app/app/modules/pages/total_income/controllers/total_income_controller.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import 'custom_line_chart.dart';

class CustomGrafikContainer extends StatelessWidget {
  final RxString selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final TotalIncomeController controller;

  final List<FlSpot> chartSpots;
  final Map<int, String> bottomLabels;
  final Map<int, String> leftLabels;

  const CustomGrafikContainer({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.controller,
    required this.chartSpots,
    required this.bottomLabels,
    required this.leftLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(items.length, (index) {
                    final label = items[index];
                    final isSelected = controller.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () => controller.onIndexChanged(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          label,
                          style:
                              isSelected
                                  ? AppTextStyles.smallTextBold
                                  : AppTextStyles.hintText,
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              switch (selectedValue.value) {
                case 'Daily':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    date: "Mei 2025",
                    reportType: selectedValue.value,
                  );

                case 'Weekly':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    date: "Juni 2025",
                    reportType: selectedValue.value,
                  );

                case 'Monthly':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    date: "2025",
                    reportType: selectedValue.value,
                  );

                case 'Yearly':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    date: "2020 – 2025",
                    reportType: selectedValue.value,
                  );

                default:
                  return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
