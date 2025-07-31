// ignore_for_file: deprecated_member_use

import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/ticket_oder_controller.dart';

class TicketOrderView extends GetView<TicketOrderController> {
  const TicketOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: Text(
            'All Ordered Tickets',
            style: AppTextStyles.label.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: CustomTextField(
                  hintText: 'Search Payment ID, Movie Title, or Status',
                  keyboardType: TextInputType.text,
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  inputStyle: AppTextStyles.body,
                  hintStyle: AppTextStyles.hintText,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 24.sp,
                  ),
                  onChanged: (value) => controller.searchQuery.value = value,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final tickets = controller.filteredTickets;

                if (tickets.isEmpty) {
                  return const Center(
                    child: Text("No matching tickets found."),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];

                    return Card(
                      color: AppColors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap:
                            () => showAdminTicketBottomSheet(context, ticket),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        leading: Icon(
                          Icons.local_activity,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          ticket['movie_title'] ?? 'Unknown Title',
                          style: AppTextStyles.label.copyWith(fontSize: 18.sp),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.w),
                            Text(
                              'Payment ID',
                              style: AppTextStyles.smallText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              ticket['payment_id'] ?? '-',
                              style: AppTextStyles.smallText,
                            ),
                            SizedBox(height: 8.w),
                            SizedBox(height: 8.w),
                            Text(
                              'Status',
                              style: AppTextStyles.smallText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showAdminTicketBottomSheet(
    BuildContext context,
    Map<String, dynamic> ticket,
  ) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    bool isLoading = false;

    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> acceptPayment() async {
              setState(() => isLoading = true);
              try {
                final snapshot =
                    await FirebaseFirestore.instance
                        .collection('tickets')
                        .where('ticket_id', isEqualTo: ticket['ticket_id'])
                        .get();
                for (var doc in snapshot.docs) {
                  await doc.reference.update({'status': 'active'});
                }
                Get.back();
                Get.snackbar(
                  'Success',
                  'Payment accepted.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to update status.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              } finally {
                setState(() => isLoading = false);
              }
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30.h),
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
                  SizedBox(height: 20.h),
                  Text('Total', style: AppTextStyles.label),
                  Text(
                    currency.format(ticket['total_price'] ?? 0),
                    style: AppTextStyles.body,
                  ),
                  SizedBox(height: 12.h),
                  Text('Payment ID', style: AppTextStyles.label),
                  Text(ticket['payment_id'] ?? '-', style: AppTextStyles.body),
                  SizedBox(height: 12.h),
                  Text('Status', style: AppTextStyles.label),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
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
                  if (ticket['selected_seats'] != null) ...[
                    SizedBox(height: 12.h),
                    Text('Selected Seats', style: AppTextStyles.label),
                    Wrap(
                      spacing: 8,
                      children:
                          List<String>.from(ticket['selected_seats']).map((
                            seat,
                          ) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
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
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: isLoading ? 'Processing...' : 'Accept Payment',
                    onPressed:
                        (ticket['status'] == 'pending' && !isLoading)
                            ? acceptPayment
                            : null,
                    backgroundColor:
                        ticket['status'] == 'pending'
                            ? AppColors.primary
                            : Colors.grey.shade300,
                    textStyle: AppTextStyles.buttonLight.copyWith(
                      fontSize: 16.sp,
                      color:
                          ticket['status'] == 'pending'
                              ? Colors.white
                              : Colors.grey,
                    ),
                    borderRadius: 12.r,
                    height: 48.h,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
