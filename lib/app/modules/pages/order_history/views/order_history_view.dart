// ignore_for_file: deprecated_member_use

import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: AppTextStyles.label.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: CustomTextField(
                hintText: 'Search orders...',
                controller: controller.searchController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                inputStyle: AppTextStyles.body,
                hintStyle: AppTextStyles.hintText,
                suffixIcon: Icon(Icons.search, color: Colors.grey, size: 24.sp),
                onChanged: (val) {
                  controller.filterTickets(val);
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredTickets.isEmpty) {
                return const Center(child: Text("No orders found."));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredTickets.length,
                itemBuilder: (context, index) {
                  final ticket = controller.filteredTickets[index];
                  final currency = NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  );

                  return GestureDetector(
                    onTap: () => showTicketDetailBottomSheet(context, ticket),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/jumbo-poster.png',
                              width: 70,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket['movie_title'] ?? 'Unknown Title',
                                  style: AppTextStyles.cardTitle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Total: ${currency.format(ticket['total_price'] ?? 0)}',
                                  style: AppTextStyles.smallText,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Payment ID: ${ticket['payment_id'] ?? '-'}',
                                  style: AppTextStyles.smallText,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        ticket['status'] == 'active'
                                            ? Colors.green.withOpacity(0.1)
                                            : ticket['status'] == 'pending'
                                            ? Colors.orange.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    ticket['status'] ?? '-',
                                    style: AppTextStyles.smallText.copyWith(
                                      color:
                                          ticket['status'] == 'active'
                                              ? Colors.green
                                              : ticket['status'] == 'pending'
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

void showTicketDetailBottomSheet(
  BuildContext context,
  Map<String, dynamic> ticket,
) {
  final currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  showModalBottomSheet(
    backgroundColor: AppColors.pageBackground,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              ticket['movie_title'] ?? 'Unknown Title',
              style: AppTextStyles.cardTitle.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: AppTextStyles.label),
                SizedBox(height: 4.w),
                Text(
                  currency.format(ticket['total_price'] ?? 0),
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment ID', style: AppTextStyles.label),
                SizedBox(height: 4.w),
                Text(
                  ticket['payment_id'] ?? '-',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status', style: AppTextStyles.label),
                SizedBox(height: 4.w),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        ticket['status'] == 'active'
                            ? Colors.green.withOpacity(0.1)
                            : ticket['status'] == 'pending'
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket['status'] ?? '-',
                    style: AppTextStyles.body.copyWith(
                      color:
                          ticket['status'] == 'active'
                              ? Colors.green
                              : ticket['status'] == 'pending'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (ticket['selected_seats'] != null) ...[
              Text('Selected Seats', style: AppTextStyles.label),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    List<String>.from(ticket['selected_seats']).map((seat) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary
                          // ignore: deprecated_member_use
                          .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Text(
                          seat,
                          style: AppTextStyles.smallText.copyWith(
                            color: AppColors.primary,
                            fontSize: 12.sp,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
            SizedBox(height: 20.w),
            CustomButton(
              text: 'View Ticket',
              onPressed:
                  ticket['status'] == 'active'
                      ? () {
                        Navigator.pop(context);
                        Get.toNamed(
                          '/ticket',
                          arguments: {
                            'movieTitle': ticket['movie_title'],
                            'selectedSeats': ticket['selected_seats'],
                            'totalPrice': ticket['total_price'],
                            'showtime': ticket['showtime'],
                          },
                        );
                      }
                      : null,
              backgroundColor:
                  ticket['status'] == 'active'
                      ? AppColors.primary
                      : Colors.grey.shade300,
              textStyle: AppTextStyles.buttonLight.copyWith(
                fontSize: 16.sp,
                color:
                    ticket['status'] == 'active' ? Colors.white : Colors.grey,
              ),
              borderRadius: 16.r,
              height: 48.h,
            ),
          ],
        ),
      );
    },
  );
}
