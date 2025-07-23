import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pages_splash_controller.dart';

class PagesSplashView extends GetView<PagesSplashController> {
  const PagesSplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/panda.json'),
            Text(
              "We're getting your details ready...",
              style: AppTextStyles.smallTextBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
