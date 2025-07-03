import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/detail_movie_controller.dart';

class DetailMovieView extends GetView<DetailMovieController> {
  const DetailMovieView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Movie', style: AppTextStyles.label),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(args['movieTitle'], style: AppTextStyles.label),

                      Text(
                        "Thursday, June 26th, 2025",
                        style: AppTextStyles.smallText,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 200.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/images/jumbo-poster.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(args["year"], style: AppTextStyles.smallText),
                            Text(args['genre'], style: AppTextStyles.smallText),
                            Text(args['duration'], style: AppTextStyles.smallText),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      StarRating(rating: args['rating']),
                      SizedBox(height: 10.h),
                      Text(
                        args["movieSynopsis"],
                        style: AppTextStyles.smallText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text("Showtime", style: AppTextStyles.label),
                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: CustomButton(
                          text: "12.00 - 13.30",
                          textStyle: AppTextStyles.body,
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          borderColor: Colors.black,
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomButton(
                  text: "Buy Ticket", 
                  backgroundColor: AppColors.primary,
                  onPressed: () {}),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
