import 'package:chingu_app/app/modules/reservation/controllers/reservation_controller.dart';
import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:chingu_app/shared/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationController());
    final args = Get.arguments as Map? ?? {};

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                  onPressed: () => Get.back(),
                ),
                Image.asset('assets/images/logo.png', width: 100.w),
                SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                legendItem(AppColors.lightGrey, 'Available'),
                legendItem(AppColors.primary, 'Reserved'),
                legendItem(AppColors.success, 'Selected'),
              ],
            ),
            SizedBox(height: 20.h),
            SvgPicture.asset('assets/images/screen.svg'),
            Text(
              'Screen',
              style: AppTextStyles.smallText.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 60.h),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(controller.blocks.length, (
                        blockIndex,
                      ) {
                        final block = controller.blocks[blockIndex];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: List.generate(block.rows, (row) {
                              return Row(
                                children: List.generate(block.cols, (col) {
                                  final seat = block.seats[row][col];
                                  Color color;
                                  switch (seat.value) {
                                    case SeatStatus.available:
                                      color = AppColors.lightGrey;
                                      break;
                                    case SeatStatus.reserved:
                                      color = AppColors.primary;
                                      break;
                                    case SeatStatus.selected:
                                      color = AppColors.success;
                                      break;
                                  }

                                  final label =
                                      '${block.name[0]}${row + 1}${col + 1}';

                                  return GestureDetector(
                                    onTap:
                                        seat.value == SeatStatus.reserved
                                            ? null
                                            : () => controller.toggleSeat(
                                              blockIndex,
                                              row,
                                              col,
                                            ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: SeatWidget(
                                        width: 36.w,
                                        height: 36.h,
                                        color: color,
                                        label: label,
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
            Obx(() {
              final selectedSeats = controller.selectedSeatLabels;
              final totalPrice = selectedSeats.length * 50000;
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL PRICE',
                              style: AppTextStyles.smallText.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp',
                                decimalDigits: 0,
                              ).format(totalPrice),
                              style: AppTextStyles.label.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'SELECTED SEATS',
                                style: AppTextStyles.smallText.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              selectedSeats.isEmpty
                                  ? Text(
                                    'No seats selected',
                                    style: AppTextStyles.label.copyWith(
                                      color: Colors.black54,
                                      fontSize: 12.sp,
                                    ),
                                  )
                                  : Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 6.w,
                                    runSpacing: 6.h,
                                    children:
                                        selectedSeats
                                            .map(
                                              (seat) => Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                  border: Border.all(
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                child: Text(
                                                  seat,
                                                  style: AppTextStyles.smallText
                                                      .copyWith(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 12.sp,
                                                      ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 24.h,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: CustomButton(
                onPressed: () {
                  final selectedSeats = controller.selectedSeatLabels;
                  if (selectedSeats.isEmpty) {
                    Get.snackbar(
                      "No Seat Selected",
                      "Please select at least one seat.",
                    );
                  } else {
                    controller.confirmBooking();
                    Get.snackbar(
                      "Success",
                      "You booked: ${selectedSeats.join(', ')}",
                    );
                    Get.toNamed(
                      "/ticket",
                      arguments: {
                        "selectedSeats": selectedSeats,
                        "movieTitle": args['movieTitle'],
                        "showtime": args['showtime'],
                        "totalPrice": selectedSeats.length * 50000,
                      },
                    );
                  }
                },
                borderRadius: 20.r,
                backgroundColor: AppColors.primary,
                text: 'Book Now',
                height: 65.h,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget legendItem(Color color, String text) {
    return Column(
      children: [
        SeatWidget(color: color, width: 36.w, height: 36.h),
        SizedBox(height: 4.h),
        Text(
          text,
          style: AppTextStyles.smallText.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
