import 'package:chingu_app/app/modules/pages/edit_profile/controllers/edit_profile_controller.dart';
import 'package:chingu_app/app/modules/pages/edit_profile/views/edit_profile_view.dart';
import 'package:chingu_app/app/modules/pages/home/controllers/home_controller.dart';
import 'package:chingu_app/app/modules/pages/home/views/home_view.dart';
import 'package:chingu_app/app/modules/pages/notification/controllers/notification_controller.dart';
import 'package:chingu_app/app/modules/pages/notification/views/notification_view.dart';
import 'package:chingu_app/app/modules/pages/order_history/controllers/order_history_controller.dart';
import 'package:chingu_app/app/modules/pages/order_history/views/order_history_view.dart';
import 'package:chingu_app/app/modules/pages/profile/controllers/profile_controller.dart';
import 'package:chingu_app/app/modules/pages/profile/views/profile_view.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => OrderHistoryController());
    Get.lazyPut(() => EditProfileController());
    Get.lazyPut(() => ProfileController());

    final List<Widget> pages = const [
      HomeView(),
      OrderHistoryView(),
      EditProfileView(),
      ProfileView(),
    ];

    return Obx(
      () => Scaffold(
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
                icon: Icons.home_rounded,
                text: 'Home',
                textStyle: AppTextStyles.navigation,
              ),
              GButton(
                icon: Icons.history,
                text: 'Order History',
                textStyle: AppTextStyles.navigation,
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notifications',
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
