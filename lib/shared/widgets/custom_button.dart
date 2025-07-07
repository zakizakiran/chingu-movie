import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final double horizontalPad;
  final double verticalPad;
  final TextStyle? textStyle;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.horizontalPad = 0.0,
    this.verticalPad = 0.0,
    this.elevation = 4.0,
    this.textStyle,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? HexColor('#85B1B4'),
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          shadowColor: Colors.black.withOpacity(0.25),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPad.w,
            vertical: verticalPad.h,
          ),
        ),
        child: Text(
          text,
          style:
              textStyle ??
              AppTextStyles.buttonLight.copyWith(fontSize: fontSize ?? 20.sp),
        ),
      ),
    );
  }
}
