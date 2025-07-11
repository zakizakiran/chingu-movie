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
                    historyView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTicketClip({
  String? movieTitle,
  String? date,
  String? selectedSeats,
  String? studio,
  Icon? icon
}) {
  return ClipPath(
    clipper: TicketPassClipper(),
    child: Container(
      height: 200.h,
      padding: EdgeInsets.all(20),
      color: AppColors.primaryLight,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 80.w,
                height: 100.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  child: Image.asset(
                    "assets/images/jumbo-poster.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 180.w,
                child: Column(
                  children: [
                    Text(
                      movieTitle ?? "Unknown movie title",
                      style: AppTextStyles.label,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Studio", style: AppTextStyles.smallText),
                              Text(
                                studio ?? "No studio selected",
                                style: AppTextStyles.smallTextBold,
                              ),
                              SizedBox(height: 5.h),
                              Text("Date", style: AppTextStyles.smallText),
                              Text(
                                date ?? "MM/DD/YY",
                                style: AppTextStyles.smallTextBold,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Seats", style: AppTextStyles.smallText),
                              Text(
                                selectedSeats ?? "No seats selected",
                                style: AppTextStyles.smallTextBold,
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          icon ?? Icon(Icons.done_all_outlined)
        ],
      ),
    ),
  );
}

Widget recentView() {
  return ListView.builder(
    itemCount: 2,
    padding: EdgeInsets.all(16),
    itemBuilder: (context, index) {
      final movieTitle = "JUMBO";
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Go to ticket ${movieTitle}")),
            );
          },
          child: buildTicketClip(
            movieTitle: movieTitle,
            selectedSeats: "C1, C2",
            studio: "1 (One)",
            date: "Wed, 16 June 2025",
            icon: Icon(Icons.qr_code_2_outlined)
          ),
        ),
      );
    },
  );
}

Widget historyView() {
  return ListView.builder(
    itemCount: 2,
    padding: EdgeInsets.all(16),
    itemBuilder: (context, index) {
      final movieTitle = "JUMBO";
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: buildTicketClip(
            movieTitle: movieTitle,
            selectedSeats: "C1, C2",
            studio: "1 (One)",
            date: "Wed, 16 June 2025",
          ),
      );
    },
  );
}
