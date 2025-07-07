import 'package:get/get.dart';

class DetailMovieController extends GetxController {
  //TODO: Implement DetailMovieController

  final count = 0.obs;

  // State untuk selected showtime
  final selectedShowtimeIndex = (-1).obs;

  // Daftar waktu showtime
  final showtimes = [
    "12.00 - 13.30 WIB",
    "15.00 - 16.30 WIB",
    "19.00 - 20.30 WIB",
  ];
  @override
  void onInit() {
    super.onInit();
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

  // Method untuk memilih showtime
  void selectShowtime(int index) {
    selectedShowtimeIndex.value = index;
  }
}
