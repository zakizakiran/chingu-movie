import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final searchController = TextEditingController();
  final moviePoster = "assets/images/jumbo-poster.png".obs;
  final movieTitle = "Jumbo Uncut";
  final movieSynopsis =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac ultrices turpis";
  final movieYear = "2024";
  final movieGenre = "Drama";
  final movieDuration = "120 min";
  final movieRating = 4.5;
  void increment() => count.value++;

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  void toggle() {
    isObscure.value = !isObscure.value;
  }
}
