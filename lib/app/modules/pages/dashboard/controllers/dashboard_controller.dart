import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  List<String> title = ["Ticket Sold Out", "Studio", "Movie"];
  List<String> value = ["1 JT", "3", "10"];
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
