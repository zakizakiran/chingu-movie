import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:custom_clippers/custom_clippers.dart';

import 'package:get/get.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('History', style: AppTextStyles.label),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: AppColors.black,
                  unselectedLabelColor: AppColors.lightGrey,
                  tabs: [Tab(text: 'Recent'), Tab(text: 'History')],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    recentView(),
                    Center(child: Text('History')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTicketClip(String text, Color color) {
  return ClipPath(
  clipper: TicketPassClipper(),
  child: Container(
    height: 100.h,
    padding: EdgeInsets.all(20),
    color: AppColors.primaryLight,
    alignment: Alignment.center,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          child: Image.asset("assets/images/jumbo-poster.png")),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jumbo", style: AppTextStyles.smallTextBold,),
              Text("C1, C2", style: AppTextStyles.smallText,),
              Text("Studio 1", style: AppTextStyles.smallText,)
            ],
          )
      ],
    )
  ),
);
}

Widget recentView() {
  return ListView.builder(
    itemCount: 5,
    padding: EdgeInsets.all(16),
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: buildTicketClip("🎟️ Tiket #${index + 1}", Colors.redAccent),
      );
    },
  );
}

