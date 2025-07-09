import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String? label;
  final TextStyle? labelStyle;

  const SeatWidget({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      alignment: Alignment.center,
      child:
          label != null
              ? Text(
                label!,
                style:
                    labelStyle ??
                    TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              )
              : null,
    );
  }
}
