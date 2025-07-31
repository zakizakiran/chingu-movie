import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool obscureText;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;
  final String? errorText;

  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final TextInputType? keyboardType;
  final int? maxLine;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.obscureText = false,
    this.width,
    this.height,
    this.fontSize,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.errorText,
    this.hintStyle,
    this.inputStyle,
    this.keyboardType,
    this.textInputAction,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        onChanged: onChanged,
        maxLines: maxLine,
        keyboardType: keyboardType,
        controller: controller,
        textInputAction: textInputAction,
        obscureText: obscureText,
        validator: validator,
        style: inputStyle ?? TextStyle(fontSize: fontSize ?? 14.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              hintStyle ?? TextStyle(color: Colors.grey, fontSize: 14.sp),
          errorText: errorText,
          contentPadding:
              contentPadding ??
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primary, width: 1.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.danger),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.danger, width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          errorStyle: AppTextStyles.error,
        ),
      ),
    );
  }
}
