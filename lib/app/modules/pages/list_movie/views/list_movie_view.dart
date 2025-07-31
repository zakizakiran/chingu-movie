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
        title: Text('Movie List', style: AppTextStyles.label),
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
                child: Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Row(
                          children: List.generate(controller.studios.length, (
                            index,
                          ) {
                            final isSelected =
                                controller.selectedStudioIndex.value == index;
                            return GestureDetector(
                              onTap:
                                  () =>
                                      controller.selectedStudioIndex.value =
                                          index,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Text(
                                  controller.studios[index],
                                  style:
                                      isSelected
                                          ? AppTextStyles.label.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )
                                          : AppTextStyles.hintText,
                                ),
                              ),
                            );
                          }),
                        );
                      }),

                      SizedBox(height: 16.h),

                      Obx(() {
                        final movies = controller.filteredMovies;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return movieCard(
                                imagePath: movie["imagePath"],
                                movieTitle: movie["title"],
                                movieStudio: movie["studio"],
                                movieDate: movie["date"],
                              );
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

  Widget miniButton({
    required String buttonName,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 8),
        child: Text(
          buttonName,
          style: AppTextStyles.hintText.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
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
      height: 160.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 100.w,
                height: 160.h,
                child: Image.asset(
                  imagePath ?? "assets/images/jumbo-poster.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieTitle ?? "Unknown Title",
                    style: AppTextStyles.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movieStudio ?? "Unavailable",
                    style: AppTextStyles.hintText,
                  ),
                  Text(movieDate ?? "DD/MM/YY", style: AppTextStyles.hintText),
                  Spacer(),
                  Row(
                    children: [
                      miniButton(buttonName: "Edit", onTap: () {}),
                      SizedBox(width: 15.w),
                      miniButton(
                        buttonName: "Delete",
                        color: AppColors.primary,
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: AppColors.white,
                            title: "Confirmation",
                            titleStyle: AppTextStyles.label,
                            middleText: "Are you sure to delete ${movieTitle ?? "Unknown"} movie?",
                            middleTextStyle: AppTextStyles.body,
                            textCancel: "Cancel",
                            textConfirm: "Yes",
                            confirmTextColor: Colors.white,
                            cancelTextColor: AppColors.primary,
                            buttonColor: AppColors.primary,
                            radius: 4,
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
