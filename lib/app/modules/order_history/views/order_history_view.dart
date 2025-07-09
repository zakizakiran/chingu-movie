import 'package:chingu_app/shared/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: const Center(
        child: Text(
          'OrderHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
