import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chingu_app/shared/widgets/custom_container.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Dashboard', style: AppTextStyles.label),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Overview", style: AppTextStyles.label,),
              SizedBox(height: 20.h),
              CustomContainer(
                cardTitle: "Total Income",
                total: "Rp. 8.000.000",
              ),
              SizedBox(height: 20.h),
              CustomContainer(
                cardTitle: "Total Tickets Sold Out",
                total: "100",
                icon: Icon(Icons.movie),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Top 5 Movie", style: AppTextStyles.cardTitle),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 300.h, 
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return CustomListContainer(
                              image: AssetImage("assets/images/jumbo-poster.png"),
                              movieTitle: "Jumbo Uncut",
                              movieViews: "1.000.000",
                              index: '${index + 1}', 
                            );
                          },
                        ),
                      ),
                    ],
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
