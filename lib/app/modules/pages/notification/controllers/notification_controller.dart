import 'package:get/get.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  final notifications =
      [
        {
          'movieTitle': 'Judul Movie 1',
          'showtimeMovie': '10.00 - 11.00 WIB',
          'movieDate' : 'Thrusday, 26 Jun 2025'
        },
        {
          'movieTitle': 'Judul Movie 1',
          'showtimeMovie': '10.00 - 11.00 WIB',
          'movieDate' : 'Thrusday, 26 Jun 2025'
        },
      ].obs;

  final count = 0.obs;

  void increment() => count.value++;
}
