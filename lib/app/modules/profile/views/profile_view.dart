import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_button_icon.dart';
import 'package:chingu_app/shared/widgets/cutom_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Icon> iconSettings = [
      Icon(Icons.edit),
      Icon(Icons.logout),];
    final List<String> profileSettings = ["Edit Profile", "Logout"];
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                    onPressed: () => Get.back(),
                  ),
                  Text("Profile", style: AppTextStyles.label),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: 165.h,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage(
                          "assets/images/profile.jpg",
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text("Harry Potter", style: AppTextStyles.label),
                      Text(
                        "harrypotter@gmail.com",
                        style: AppTextStyles.smallText,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.w),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.w,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      children: [
                        ...List.generate(profileSettings.length, (index) {
                          final setting = profileSettings[index];
                          final icon =
                              iconSettings;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: CustomButtonIcon(
                              backgroundColor: AppColors.primaryLight
                                  .withOpacity(0.3),
                              borderColor: AppColors.primary,
                              text: setting,
                              textStyle: TextStyle(color: AppColors.black),
                              icon: icon[index],
                              onPressed: () {
                                if (setting == "Logout") {
                                  Get.toNamed("/login");
                                } else if (setting == "Edit Profile") {}
                              },
                            ),
                          );
                        }),
                      ],
                    ),
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
