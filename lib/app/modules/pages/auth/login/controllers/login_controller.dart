import 'package:chingu_app/app/controller/storage_service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final storageService = Get.find<StorageService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists) {
          final fullName = doc.data()?['full_name'] ?? '';
          final userEmail = doc.data()?['email'] ?? '';
          final role = doc.data()?['role'] ?? 'user';

          await storageService.saveFullName(fullName);
          await storageService.saveEmail(userEmail);
          await storageService.saveUserRole(role);

          Get.log('Login successful: $fullName, $userEmail, $role');

          if (role == 'admin') {
            Get.offAllNamed('/notification');
          } else {
            Get.offAllNamed('/bottom-navigation');
          }
        }
      } else {
        Get.snackbar('Login Error', 'User ID not found');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Error',
        e.message ?? 'An error occurred during login',
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggle() {
    isObscure.value = !isObscure.value;
  }
}
