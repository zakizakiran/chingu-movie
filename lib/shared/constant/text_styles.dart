import 'package:chingu_app/shared/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle get loginTitle => GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get cardTitle => GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get label => GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle get buttonLight => GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get buttonDark => GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle get subtitle => GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
  );

  static TextStyle get body => GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle get smallText => GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle get hintText => GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGrey,
  );

  static TextStyle get error => GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.danger,
  );
}
