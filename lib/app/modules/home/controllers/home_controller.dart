import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final searchController = TextEditingController();
  void increment() => count.value++;
}
