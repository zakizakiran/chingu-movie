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
        FocusScope.of(context).unfocus();
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
                SizedBox(height: 12.h),

                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          controller.genres.map((genre) {
                            final isSelected =
                                genre == controller.selectedGenre.value;
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: ChoiceChip(
                                elevation: 0,
                                label: Text(
                                  genre,
                                  style: AppTextStyles.body.copyWith(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : AppColors.text,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected:
                                    (_) => controller.selectGenre(genre),
                                selectedColor: AppColors.primary,
                                backgroundColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.52.w,
                      children:
                          controller.filteredMovies.map((movie) {
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
                                        'studio': movie['studio'],
                                        'movieTitle': movie['title'],
                                        'movieSynopsis': movie['synopsis'],
                                        'year': movie['year'],
                                        'genre': movie['genre'],
                                        'duration': movie['duration'],
                                        'rating': movie['rating'],
                                        'poster_url': movie['poster_url'],
                                      },
                                    );
                                  },
                                  child: CustomCard(
                                    image: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          movie['poster_url'] ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (_, __, ___) => const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ),

                                    controller: controller,
                                    title: movie['title'],
                                    description: movie['synopsis'],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
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
