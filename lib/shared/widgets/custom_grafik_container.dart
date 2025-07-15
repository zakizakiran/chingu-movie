import 'package:chingu_app/app/modules/pages/total_income/controllers/total_income_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';

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
    List<Color> gradientColors = [AppColors.primary, AppColors.secondary];

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
                  return Container(
                    width: double.infinity,
                    color: AppColors.pageBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Daily Report Total Income", style: AppTextStyles.smallTextBold),
                        Text("Thursday, June 26th, 2025", style: AppTextStyles.hintText),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 250,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 18,
                                  left: 12,
                                  top: 24,
                                  bottom: 12,
                                ),
                                child: Obx(() => LineChart(
                                  controller.showAvg.value
                                      ? avgData(gradientColors)
                                      : mainData(gradientColors),
                                )),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Obx(() => TextButton(
                                  onPressed: () {
                                    controller.showAvg.value = !controller.showAvg.value;
                                  },
                                  child: Text(
                                    'avg',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: controller.showAvg.value
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white,
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                case 'Weekly':
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.green[50],
                    child: const Text("📆 Menampilkan laporan mingguan"),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.smallText;
    final label = bottomLabels[value.toInt()] ?? '';
    return SideTitleWidget(meta: meta, child: Text(label, style: style));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.smallText;
    final label = leftLabels[value.toInt()];
    if (label == null) return Container();
    return Text(label, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<Color> gradientColors) {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: controller.spots.isNotEmpty ? controller.spots.last.x : 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: chartSpots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((c) => c.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(List<Color> gradientColors) {
    final avgY = chartSpots.isEmpty ? 0.0 : chartSpots.map((e) => e.y).reduce((a, b) => a + b) / chartSpots.length;
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: controller.spots.isNotEmpty ? controller.spots.last.x : 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: chartSpots.map((e) => FlSpot(e.x, avgY)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              gradientColors[0].withOpacity(0.5),
              gradientColors[1].withOpacity(0.5),
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                gradientColors[0].withOpacity(0.1),
                gradientColors[1].withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}