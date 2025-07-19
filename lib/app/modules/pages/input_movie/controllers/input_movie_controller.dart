import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputMovieController extends GetxController {
  //TODO: Implement InputMovieController
  // Text fields
  final titleController = TextEditingController();
  final synopsisController = TextEditingController();
  final priceController = TextEditingController();

  // Dropdown and date
  var selectedGenre = ''.obs;
  var selectedDate = ''.obs;

  // Image
  var selectedImage = Rx<File?>(null);

  // Optional: method to reset after submit
  void resetFields() {
    titleController.clear();
    synopsisController.clear();
    priceController.clear();
    selectedGenre.value = '';
    selectedDate.value = '';
    selectedImage.value = null;
  }

  


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
