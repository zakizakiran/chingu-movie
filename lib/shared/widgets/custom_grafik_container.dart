import 'package:chingu_app/app/modules/pages/total_income/controllers/total_income_controller.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import 'custom_line_chart.dart';

class CustomGrafikContainer extends StatelessWidget {
  final String title;
  final RxString selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final TotalIncomeController controller;

  final List<FlSpot> chartSpots;
  final Map<int, String> bottomLabels;
  final Map<int, String> leftLabels;

  const CustomGrafikContainer({
    super.key,
    required this.title,
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
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.smallTextBold),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Obx(() {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedValue.value,
                        onChanged: onChanged,
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: AppTextStyles.smallText),
                          );
                        }).toList(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() {
              switch (selectedValue.value) {
                case 'Daily':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    date: "June 2025",
                    reportType: selectedValue.value,
                  );
                case 'Weekly':
                  return CustomLineChart(
                    controller: controller,
                    chartSpots: chartSpots,
                    bottomLabels: bottomLabels,
                    leftLabels: leftLabels,
                    reportType: selectedValue.value,
                    date: "June 2025",
                  );
                case 'Monthly':
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.orange[50],
                    child: const Text("🗓️ Menampilkan laporan bulanan"),
                  );
                case 'Yearly':
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.purple[50],
                    child: const Text("📊 Menampilkan laporan tahunan"),
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
