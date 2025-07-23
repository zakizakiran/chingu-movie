import 'package:chingu_app/app/controller/storage_service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final storageService = Get.find<StorageService>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController(text: 'user');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isAgree = false.obs;
  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  void toggle() {
    isObscure.value = !isObscure.value;
  }

  Future<void> completeSign() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSigned', true);

    final role = await storageService.getUserRole();
    if (role == 'admin') {
      Get.offAllNamed('/admin-navigation');
    } else {
      Get.offAllNamed('/bottom-navigation');
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!isAgree.value) {
      Get.snackbar('Error', 'Please agree to the terms and conditions');
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      if (Firebase.apps.isEmpty) {
        Get.snackbar('Error', 'Firebase not initialized properly');
        isLoading.value = false;
        return;
      }

      // App Check temporarily disabled to avoid reCAPTCHA configuration issues
      // Will be re-enabled when proper reCAPTCHA keys are configured

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = userCredential.user;
      if (user != null) {
        final userData = {
          'id': user.uid,
          'full_name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'role': roleController.text.trim(),
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
          'email_verified': false,
        };

        await _firestore.collection('users').doc(user.uid).set(userData);

        await storageService.saveFullName(nameController.text.trim());
        await storageService.saveEmail(emailController.text.trim());
        await storageService.saveUserRole(roleController.text.trim());

        await user.sendEmailVerification();

        emailController.clear();
        nameController.clear();
        passwordController.clear();
        roleController.clear();
        isObscure.value = true;
        isAgree.value = false;
        isConfirmObscure.value = true;

        Get.snackbar(
          'Success',
          'Registration successful! Please verify your email.',
          snackPosition: SnackPosition.BOTTOM,
        );

        completeSign();
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    roleController.dispose();
    super.onClose();
  }
}
