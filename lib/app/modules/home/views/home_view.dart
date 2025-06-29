import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150.w,
                    height: 150.h,
                  ),
                ),
                Form(
                  child: CustomTextField(
                    hintText: 'search',
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.searchController,
                    textInputAction: TextInputAction.next,
                    inputStyle: AppTextStyles.body,
                    hintStyle: AppTextStyles.hintText,
                  ),
                ),
                SizedBox(height: 15.h),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true, //tinggi otomatis menyesuaikan isi
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.57,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: EdgeInsets.all(9),
                      child: SizedBox(
                        width: 160.w,
                        height: 500.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/jumbo-poster.png',
                              width: 165.w,
                              height: 200.h,
                            ),
                            Text("Jumbo", style: AppTextStyles.label),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac ultrices turpis",
                              style: AppTextStyles.smallText,
                              // textAlign: TextAlign.justify,
                              maxLines: 3, 
                              overflow:
                                  TextOverflow.ellipsis,  
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
