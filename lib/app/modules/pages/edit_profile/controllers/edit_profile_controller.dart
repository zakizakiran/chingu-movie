import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }

  // Validate username and password
  String? validateFullName(String value) {
    if (value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 3) {
      return "Username must be at least 3 characters long";
    }
    return null;
  }

  // Load user data from Firestore
  void _loadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userData =
            await _firestore.collection('users').doc(user.uid).get();
        fullNameController.text = userData['full_name'] ?? '';
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load user data",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Save profile changes to Firestore
  void saveProfile() async {
    final fullName = fullNameController.text;

    final fullNameError = validateFullName(fullName);

    if (fullNameError != null) {
      Get.snackbar("Error", fullNameError, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Update Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'full_name': fullName,
        });

        Get.snackbar(
          "Success",
          "Profile updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
