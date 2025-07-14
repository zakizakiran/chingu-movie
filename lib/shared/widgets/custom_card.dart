import 'package:chingu_app/app/modules/pages/home/controllers/home_controller.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final String? description;
  final Image? image;

  const CustomCard({
    super.key,
    required this.controller,
    this.image,
    this.title,
    this.description,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image ?? Image.asset('assets/images/jumbo-poster.png'),
            SizedBox(height: 8.h),
            Text(title!, style: AppTextStyles.cardTitle),
            SizedBox(height: 4.h),
            Text(
              description!,
              style: AppTextStyles.smallText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
