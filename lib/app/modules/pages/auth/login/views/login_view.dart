import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                  Text('Login', style: AppTextStyles.loginTitle),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter your credentials and get back to the chingu world',
                    style: AppTextStyles.body,
                  ),
                  SizedBox(height: 28.h),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            Text(
                              'Forgot Password?',
                              style: AppTextStyles.smallText,
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx(
                              () => CustomButton(
                                width: 271.w,
                                height: 60.h,
                                text:
                                    controller.isLoading.value
                                        ? 'Signing in...'
                                        : 'Sign in',
                                textStyle: AppTextStyles.buttonLight,
                                backgroundColor:
                                    controller.isLoading.value
                                        // ignore: deprecated_member_use
                                        ? AppColors.primary.withOpacity(0.7)
                                        : AppColors.primary,
                                borderRadius: 15.r,
                                onPressed:
                                    controller.isLoading.value
                                        ? null
                                        : () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            controller.login(
                                              controller.emailController.text,
                                              controller
                                                  .passwordController
                                                  .text,
                                            );
                                          } else {
                                            Get.snackbar(
                                              'Form Error',
                                              'Please fill in both email and password.',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red
                                              // ignore: deprecated_member_use
                                              .withOpacity(0.8),
                                              colorText: Colors.white,
                                              margin: const EdgeInsets.all(16),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            );
                                          }
                                        },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: AppTextStyles.smallText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/register'); // Navigate to register page
                        },
                        child: Text(
                          ' Register now',
                          style: AppTextStyles.smallText.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
