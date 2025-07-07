import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final searchController = TextEditingController();
  final movieTitle = "Jumbo"; 
  final movieSynopsis = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac ultrices turpis"; 
  void increment() => count.value++;

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  void toggle() {
    isObscure.value = !isObscure.value;
  }
}
