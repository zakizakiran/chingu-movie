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
    final args = Get.arguments as Map? ?? {};

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Movies Detail', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
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
                      SizedBox(height: 12.h),
                      Text(
                        args['movieTitle'] ?? 'Unknown Title',
                        style: AppTextStyles.label,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Thursday, June 26th, 2025",
                        style: AppTextStyles.smallText,
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        height: 200.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                              args['moviePoster'] != null
                                  ? Image.asset(
                                    args['moviePoster'] as String,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    "assets/images/jumbo-poster.png",
                                    // Default image if no poster is provided
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
                            Text(
                              args["year"]?.toString() ?? '',
                              style: AppTextStyles.smallText,
                            ),
                            Text(
                              args['genre']?.toString() ?? '',
                              style: AppTextStyles.smallText,
                            ),
                            Text(
                              args['duration']?.toString() ?? '',
                              style: AppTextStyles.smallText,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      StarRating(
                        rating: (args['rating'] as num?)?.toDouble() ?? 0.0,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        args["movieSynopsis"]?.toString() ??
                            'No synopsis available',
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
                  child: Obx(
                    () => Column(
                      children: List.generate(controller.showtimes.length, (
                        index,
                      ) {
                        final isSelected =
                            controller.selectedShowtimeIndex.value == index;
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: CustomButton(
                            text: controller.showtimes[index],
                            textStyle:
                                isSelected
                                    ? AppTextStyles.body.copyWith(
                                      color: AppColors.white,
                                    )
                                    : AppTextStyles.body,
                            onPressed: () {
                              controller.selectShowtime(index);
                            },
                            backgroundColor:
                                isSelected ? AppColors.black : Colors.white,
                            borderColor:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.lightGrey,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Obx(
                  () => CustomButton(
                    text: "Buy Ticket",
                    backgroundColor:
                        controller.selectedShowtimeIndex.value >= 0
                            ? AppColors.primary
                            : AppColors.lightGrey,
                    textStyle: AppTextStyles.buttonLight,
                    borderRadius: 20.r,
                    height: 65.h,
                    onPressed:
                        controller.selectedShowtimeIndex.value >= 0
                            ? () {
                              Get.snackbar(
                                "Showtime Selected",
                                "You selected: ${controller.showtimes[controller.selectedShowtimeIndex.value]}",
                                backgroundColor: AppColors.darkGrey,
                                colorText: Colors.white,
                              );
                              Get.toNamed(
                                '/reservation',
                                arguments: {
                                  'movieTitle': args['movieTitle'],
                                  'showtime':
                                      controller.showtimes[controller
                                          .selectedShowtimeIndex
                                          .value],
                                },
                              );
                            }
                            : null,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
