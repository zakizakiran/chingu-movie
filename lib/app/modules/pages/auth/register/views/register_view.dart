import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_button_icon.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.primaryLight,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png', width: 100, height: 100),
                Text('Create Account', style: AppTextStyles.loginTitle),
                SizedBox(height: 8.h),
                SizedBox(
                  width: context.width * 0.8.w,
                  child: Text(
                    'One step away from joining the ultimate cinema experience',
                    style: AppTextStyles.body,
                  ),
                ),
                SizedBox(height: 28.h),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: AppTextStyles.label),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        hintText: 'John Doe',
                        keyboardType: TextInputType.name,
                        controller: controller.nameController,
                        textInputAction: TextInputAction.next,
                        inputStyle: AppTextStyles.body,
                        hintStyle: AppTextStyles.hintText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text('Email', style: AppTextStyles.label),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        hintText: 'anonymous@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        textInputAction: TextInputAction.next,
                        inputStyle: AppTextStyles.body,
                        hintStyle: AppTextStyles.hintText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text('Password', style: AppTextStyles.label),
                      SizedBox(height: 12.h),
                      Obx(
                        () => CustomTextField(
                          hintText: '*********',
                          keyboardType: TextInputType.visiblePassword,
                          controller: controller.passwordController,
                          obscureText: controller.isObscure.value,
                          inputStyle: AppTextStyles.body,
                          hintStyle: AppTextStyles.hintText,

                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscure.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: AppColors.primary,
                            ),
                            onPressed: controller.toggle,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.isAgree.value,
                              onChanged: (value) {
                                controller.isAgree.value = value ?? false;
                              },
                              activeColor: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'I agree to the ',
                                style: AppTextStyles.smallText,
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style:
                                        AppTextStyles.smallTextBold.copyWith(),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: AppTextStyles.smallText,
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppTextStyles.smallTextBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(
                            () => CustomButton(
                              onPressed:
                                  controller.isLoading.value
                                      ? null
                                      : () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.signUp();
                                        }
                                      },
                              borderRadius: 20.r,
                              backgroundColor: AppColors.primary,
                              text: 'Create Account',
                              height: 65.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          'or sign up with',
                          style: AppTextStyles.smallText,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomButtonIcon(
                            onPressed: () {},
                            borderRadius: 20.r,
                            icon: Image.asset(
                              'assets/images/icon_google.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.lightGrey,
                            text: 'Google',
                            textStyle: AppTextStyles.buttonDark,
                            height: 65.h,
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
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
}
