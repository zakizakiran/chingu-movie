import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<String> movieTitle = ['Jumbo', 'Harry Potter', 'Moving', 'Squid Game'];
  List<double> totalTicket = [200, 150, 100, 50];

  List<String> title = ["Ticket Sold Out", "Movie"];
  List<String> get value => [
    '${totalTicket.reduce((a, b) => a + b).toInt()}',
    '${movieTitle.length}',
  ];
  List<String> information = ["June 2025", "Active"];
  String? income = "9.000.000";
  String? date = "June 2025";

  final count = 0.obs;

  void increment() => count.value++;
}
