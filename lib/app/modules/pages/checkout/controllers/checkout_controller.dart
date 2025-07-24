
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController
  late int servicesFee = 5000;
  late List selectedSeats;
  late int totalServicesFee;
  late int totalFee = 0;

  String get todayFormatted => _getFormattedTodayDate();

  String _getFormattedTodayDate() {
    final now = DateTime.now();
    final day = now.day;
    final suffix = _getDaySuffix(day);
    final dayWithSuffix = '$day$suffix';

    final formatted = DateFormat('EEEE, MMMM').format(now);
    final year = DateFormat('y').format(now);

    return '$formatted $dayWithSuffix, $year';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    selectedSeats = args["selectedSeats"];
    totalServicesFee = servicesFee * selectedSeats.length;
    totalFee = (totalServicesFee + args["totalPrice"]).toInt();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
