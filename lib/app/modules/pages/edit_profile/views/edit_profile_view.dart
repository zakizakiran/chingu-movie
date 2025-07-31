import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Edit Profile',
          style: AppTextStyles.label.copyWith(color: AppColors.pageBackground),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100.h,
                      decoration: BoxDecoration(color: AppColors.primary),
                    ),
                    SizedBox(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150.h,
                            decoration: BoxDecoration(color: AppColors.primary),
                          ),
                          Positioned(
                            top: 70,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 0,
                              height: 150.h,
                              decoration: BoxDecoration(
                                color: AppColors.pageBackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 45.r,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      customInputFieldFull(
                        controller: controller.fullNameController,
                        label: "Username",
                        hint: "Enter your username",
                        maxLines: 1,
                      ),
                      SizedBox(height: 40.h),
                      CustomButton(
                        text: "Save Changes",
                        backgroundColor: AppColors.primary,
                        textStyle: AppTextStyles.buttonLight,
                        borderRadius: 20.r,
                        height: 65.h,
                        onPressed: () {
                          controller.saveProfile();
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customInputFieldFull({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    final isMultiline = maxLines > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50,
            maxHeight: isMultiline ? 200 : 60,
          ),
          child: TextField(
            controller: controller,
            maxLines: isMultiline ? null : 1,
            keyboardType:
                isMultiline ? TextInputType.multiline : TextInputType.text,
            style: AppTextStyles.smallText.copyWith(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.hintText,
              border: const UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    RxBool? isObscured,
  }) {
    final isObscured0 = isObscured ?? true.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        Obx(
          () => TextField(
            controller: controller,
            obscureText: isObscured0.value,
            style: AppTextStyles.smallText.copyWith(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.hintText,
              border: const UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscured0.value ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  isObscured0.value = !isObscured0.value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
