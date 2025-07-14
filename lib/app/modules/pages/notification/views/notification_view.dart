import 'package:chingu_app/shared/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: const Center(
        child: Text(
          'NotificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
