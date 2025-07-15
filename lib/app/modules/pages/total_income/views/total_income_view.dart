import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_grafik_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomGrafikContainer(
                title: 'Total Income',
                selectedValue: controller.selectedType,
                items: ['Daily', 'Weekly', 'Monthly', 'Yearly'],
                onChanged: controller.onDropdownChanged,
                controller: controller,
                chartSpots: controller.spots,
                bottomLabels: controller.bottomAxisLabels,
                leftLabels: controller.leftAxisLabels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
