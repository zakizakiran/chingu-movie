import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/list_movie_controller.dart';

class ListMovieView extends GetView<ListMovieController> {
  const ListMovieView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('List Movie', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Form(
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
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.movieList.length,
                    itemBuilder: (context, index) {
                      final movie = controller.movieList[index];
                      return movieCard(
                        imagePath: movie["imagePath"],
                        movieTitle: movie["title"],
                        movieStudio: movie["studio"],
                        movieDate: movie["date"],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget miniButton({String? buttonName, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 8),
      child: Text(
        buttonName ?? "Edit",
        style: AppTextStyles.hintText.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget movieCard({
    String? imagePath,
    String? movieTitle,
    String? movieStudio,
    String? movieDate,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 120.w,
                height: 150.h,
                child: Image.asset(
                  imagePath ?? "assets/images/jumbo-poster.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(movieTitle ?? "Unknown Title", style: AppTextStyles.label),
                Text(
                  movieStudio ?? "Unavailable",
                  style: AppTextStyles.hintText,
                ),
                Text(movieDate ?? "DD/MM/YY", style: AppTextStyles.hintText),
                SizedBox(height: 49.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    miniButton(buttonName: "Edit"),
                    SizedBox(width: 10.w),
                    miniButton(buttonName: "Delete", color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
