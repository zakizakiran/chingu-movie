import 'package:chingu_app/app/modules/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:chingu_app/app/modules/pages/dashboard/views/dashboard_view.dart';
import 'package:chingu_app/app/modules/pages/notification/controllers/notification_controller.dart';
import 'package:chingu_app/app/modules/pages/notification/views/notification_view.dart';
import 'package:chingu_app/app/modules/pages/profile/controllers/profile_controller.dart';
import 'package:chingu_app/app/modules/pages/profile/views/profile_view.dart';
import 'package:chingu_app/app/modules/pages/total_income/controllers/total_income_controller.dart';
import 'package:chingu_app/app/modules/pages/total_income/views/total_income_view.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

import '../controllers/admin_navigation_controller.dart';

class AdminNavigationView extends GetView<AdminNavigationController> {
  const AdminNavigationView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => TotalIncomeController());
    Get.lazyPut(() => ProfileController());

    final List<Widget> pages = const [
      DashboardView(),
      TotalIncomeView(),
      ProfileView(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: GNav(
            backgroundColor: AppColors.white,
            gap: 5,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            color: AppColors.lightGrey,
            activeColor: AppColors.white,
            tabBackgroundColor: AppColors.primaryLight,
            tabActiveBorder: Border.all(color: AppColors.primary, width: 1),
            selectedIndex: controller.currentIndex.value,
            onTabChange: controller.changePage,
            tabs: [
              GButton(
                icon: Icons.dashboard,
                text: 'Dashboard',
                textStyle: AppTextStyles.navigation,
              ),
              GButton(
                icon: Icons.info_rounded,
                text: 'Reports',
                textStyle: AppTextStyles.navigation,
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
                textStyle: AppTextStyles.navigation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
