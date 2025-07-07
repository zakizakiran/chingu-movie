import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_card.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', width: 140.w),
                ),
                Form(
                  child: CustomTextField(
                    hintText: 'Search here',
                    keyboardType: TextInputType.text,
                    controller: controller.searchController,
                    textInputAction: TextInputAction.search,
                    inputStyle: AppTextStyles.body,
                    hintStyle: AppTextStyles.hintText,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.52.w,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                '/detail-movie',
                                arguments: {
                                  'movieTitle': controller.movieTitle,
                                  'movieSynopsis': controller.movieSynopsis,
                                  'year': controller.movieYear,
                                  'genre': controller.movieGenre,
                                  'duration': controller.movieDuration,
                                  'rating': controller.movieRating,
                                },
                              );
                            },
                            child: CustomCard(
                              image: Image.asset(controller.moviePoster.value),
                              controller: controller,
                              title: controller.movieTitle,
                              description: controller.movieSynopsis,
                            ),
                          ),
                        ),
                      );
                    }),
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
