import 'package:chingu_app/app/modules/home/controllers/home_controller.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final String? description;

  const CustomCard({
    super.key,
    required this.controller,
    this.title,
    this.description,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/jumbo-poster.png'),
            SizedBox(height: 8.h),
            Text(controller.movieTitle, style: AppTextStyles.cardTitle),
            SizedBox(height: 4.h),
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
    );
  }
}
