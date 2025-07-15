import 'package:chingu_app/app/modules/pages/total_income/controllers/total_income_controller.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLineChart extends StatelessWidget {
  final TotalIncomeController controller;
  final List<FlSpot> chartSpots;
  final Map<int, String> bottomLabels;
  final Map<int, String> leftLabels;
  final String? reportType;
  final String? date;

  const CustomLineChart({
    super.key,
    required this.controller,
    required this.chartSpots,
    required this.bottomLabels,
    required this.leftLabels,
    this.reportType,
    this.date
  });

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

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [AppColors.primary, AppColors.secondary];

    return Container(
      width: double.infinity,
      color: AppColors.pageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${reportType ?? "Null"} Report Total Income", style: AppTextStyles.smallTextBold),
          Text(date ?? "DD/MM/YY", style: AppTextStyles.hintText),
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
  }
}
