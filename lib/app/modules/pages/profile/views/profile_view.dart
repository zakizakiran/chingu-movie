import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Icon> iconSettings = [Icon(Icons.edit), Icon(Icons.logout)];
    final List<String> profileSettings = ["Edit Profile", "Logout"];
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Center(
                child: Text(
                  "My Profile",
                  style: AppTextStyles.label.copyWith(color: AppColors.text),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
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
                      SizedBox(height: 16.h),
                      Obx(
                        () => Text(
                          controller.fullName.value,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.email.value,
                          style: AppTextStyles.smallText.copyWith(
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: AppColors.lightGrey, height: 20.h),
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
                  child: Column(
                    children: [
                      ...List.generate(profileSettings.length, (index) {
                        final setting = profileSettings[index];
                        final icon = iconSettings;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CustomButtonIcon(
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.lightGrey,
                            text: setting,
                            textStyle: TextStyle(color: AppColors.black),
                            icon: icon[index],
                            onPressed: () {
                              if (setting == "Logout") {
                                controller.logout();
                                Get.snackbar(
                                  "Logout",
                                  "You have been logged out successfully.",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else if (setting == "Edit Profile") {}
                            },
                          ),
                        );
                      }),
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
