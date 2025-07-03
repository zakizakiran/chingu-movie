import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/logo.png', height: 140.h),
              ),
              Form(
                child: CustomTextField(
                  hintText: 'search',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.searchController,
                  textInputAction: TextInputAction.next,
                  inputStyle: AppTextStyles.body,
                  hintStyle: AppTextStyles.hintText,
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: EdgeInsets.all(9),
                      child: SizedBox(
                        width: 160.w,
                        height: 500.h,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/detail-movie',
                              arguments: {
                                'movieTitle': controller.movieTitle,
                                'movieSynopsis': controller.movieSynopsis,
                                'rating' : controller.rating,
                                'genre' : controller.genre,
                                'year' : controller.year,
                                'duration' : controller.duration
                                },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/jumbo-poster.png',
                                width: 165.w,
                                height: 200.h,
                              ),
                              Text(
                                controller.movieTitle,
                                style: AppTextStyles.label,
                              ),
                              Text(
                                controller.movieSynopsis,
                                style: AppTextStyles.smallText,
                                // textAlign: TextAlign.justify,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
    );
  }
}
