import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  List<String> movieTitle = ['Jumbo', 'Harry Potter', 'Moving', 'Squid Game'];
  List<double> totalTicket = [200, 150, 100, 50];

  List<String> title = ["Ticket Sold Out", "Studio", "Movie"];
  List<String> get value => ['${totalTicket.reduce((a, b) => a + b).toInt()}', "3", '${movieTitle.length}'];
  List<String> information = ["June 2025", "Active", "Active"];
  String? income = "9.000.000";
  String? date = "June 2025";

  


  final count = 0.obs;
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
}
