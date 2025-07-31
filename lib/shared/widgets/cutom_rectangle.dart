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
      width: (width ?? 100).w,
      height: (height ?? 100).h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
