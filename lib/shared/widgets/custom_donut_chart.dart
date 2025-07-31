import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatefulWidget {
  final List<String>? labels;
  final List<double>? values;
  final List<Color>? colors;

  const DonutChart({super.key, this.labels, this.values, this.colors});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  int touchedIndex = -1;

  List<String> get labels => widget.labels ?? [];
  List<double> get values => widget.values ?? [];
  List<Color> get colors => widget.colors ?? [];

  double get totalValue => values.fold(0.0, (sum, val) => sum + val);

  @override
  Widget build(BuildContext context) {
    final isValidData =
        labels.length == values.length &&
        values.length == colors.length &&
        labels.isNotEmpty;

    if (!isValidData) {
      return const Center(child: Text("Data tidak valid atau kosong"));
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  if (!event.isInterestedForInteractions ||
                      response?.touchedSection == null) {
                    setState(() => touchedIndex = -1);
                    return;
                  }
                  final touchedSection = response?.touchedSection;
                  if (touchedSection != null) {
                    setState(
                      () => touchedIndex = touchedSection.touchedSectionIndex,
                    );
                  }
                },
              ),
              sections: List.generate(values.length, (i) {
                final isTouched = i == touchedIndex;
                return PieChartSectionData(
                  color: colors[i],
                  value: values[i],
                  title:
                      '${((values[i] / totalValue) * 100).toStringAsFixed(0)}%',
                  radius: isTouched ? 60 : 50,
                  titleStyle: TextStyle(
                    fontSize: isTouched ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ),
        ),
        if (touchedIndex != -1)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              '${labels[touchedIndex]}: ${values[touchedIndex].toInt()} tickets',
              style: AppTextStyles.smallText,
            ),
          ),
      ],
    );
  }
}
