import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  void toggle() {
    isObscure.value = !isObscure.value;
  }
}
