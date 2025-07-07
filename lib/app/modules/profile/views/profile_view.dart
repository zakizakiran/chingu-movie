import 'package:chingu_app/shared/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: const Center(
        child: Text('ProfileView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
