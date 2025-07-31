import 'package:get/get.dart';

class DetailMovieController extends GetxController {
  final count = 0.obs;
  final selectedShowtimeIndex = (-1).obs;

  final showtimes = [
    "12.00 - 13.30 WIB",
    "15.00 - 16.30 WIB",
    "19.00 - 20.30 WIB",
  ];

  @override
  void onClose() {
    selectedShowtimeIndex.value = -1; // Reset selected showtime
    super.onClose();
  }

  void increment() => count.value++;

  // Method untuk memilih showtime
  void selectShowtime(int index) {
    selectedShowtimeIndex.value = index;
  }
}
