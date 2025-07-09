import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRectangle extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const CustomRectangle({super.key, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width!.w,
      height: height!.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
