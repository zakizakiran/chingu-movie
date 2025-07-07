import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final searchController = TextEditingController();
  final movieTitle = "Jumbo";
  final movieSynopsis = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac ultrices turpis, nec dapibus eros. Aliquam euismod lorem dolor. Proin tellus mauris, rutrum vestibulum arcu ac, dignissim hendrerit ligula. In accumsan gravida vehicula. Duis sed ipsum sed est fringilla lobortis. Quisque viverra dui quis ligula tempor, ";
  final rating = 3.5;
  final genre = "Comedy";
  final year = "2025";
  final duration = "2h 31m"; 
  final date = "Thursday, June 26th, 2025";
  final showtime = ["12.00 - 13.30", "14.00 - 15.00", "16.00 - 17.00"];
  
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
