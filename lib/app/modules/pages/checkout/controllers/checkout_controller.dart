import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {
  late List<String> selectedSeats;
  late String movieTitle;
  late String showTime;
  late int pricePerSeat;
  late int totalPrice;
  late int totalServicesFee;
  late int totalFee;

  final servicesFee = 5000;
  final status = 'pending';

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    selectedSeats = List<String>.from(args['selectedSeats'] ?? []);
    movieTitle = args['movieTitle'] ?? '';
    showTime = args['showtime'] ?? '';
    pricePerSeat = args['price'] ?? 0;

    totalPrice = selectedSeats.length * pricePerSeat;
    totalServicesFee = selectedSeats.length * servicesFee;
    totalFee = totalPrice + totalServicesFee;
  }

  Future<String> generatePaymentId() async {
    final today = DateTime.now();
    final dateString = DateFormat('yyyyMMdd').format(today);

    // Hitung jumlah transaksi pada tanggal ini
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final snapshot =
        await firestore
            .collection('tickets')
            .where(
              'created_at',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
            )
            .where(
              'created_at',
              isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
            )
            .get();

    final count = snapshot.size + 1; // urutan berikutnya
    final paddedCount = count.toString().padLeft(4, '0');

    return 'pid-$dateString-$paddedCount';
  }

  Future<void> saveTicket() async {
    try {
      final docRef = firestore.collection('tickets').doc();
      final paymentId = await generatePaymentId();

      await docRef.set({
        'ticket_id': docRef.id,
        'user_id': FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user',
        'movie_title': movieTitle,
        'payment_id': paymentId,
        'showtime': showTime,
        'selected_seats': selectedSeats,
        'total_price': totalFee,
        'status': status,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      errorMessage.value = 'Failed to save ticket. Please try again.';
      Get.snackbar('Error', errorMessage.value);
      return;
    }
  }

  String get todayFormatted {
    final now = DateTime.now();
    final day = now.day;
    final suffix = _getDaySuffix(day);
    final formatted = DateFormat('EEEE, MMMM').format(now);
    final year = DateFormat('y').format(now);
    return '$formatted $day$suffix, $year';
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
}
