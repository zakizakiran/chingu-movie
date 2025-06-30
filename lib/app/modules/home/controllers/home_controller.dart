import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final searchController = TextEditingController();
  final movieTitle = "Jumbo";
  final movieSynopsis = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac ultrices turpis, nec dapibus eros. Aliquam euismod lorem dolor. Proin tellus mauris, rutrum vestibulum arcu ac, dignissim hendrerit ligula. In accumsan gravida vehicula. Duis sed ipsum sed est fringilla lobortis. Quisque viverra dui quis ligula tempor, ";

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
