import 'package:chingu_app/app/controller/storage_service_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PagesSplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5), () async {
      final isLoggedIn = _auth.currentUser != null;

      Get.log('User is logged in: $isLoggedIn');

      if (!isLoggedIn) {
        Get.offAllNamed('/login');
      } else {
        await _checkUserRole();
      }
    });
  }

  Future<void> _checkUserRole() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final role = userDoc.data()?['role'] ?? 'user';
          Get.log('User role: $role');

          await _storageService.saveUserRole(role);

          if (role == 'admin') {
            Get.offAllNamed('/admin-navigation');
          } else {
            Get.offAllNamed('/bottom-navigation');
          }
        } else {
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.log('Error checking user role: $e');
      Get.snackbar('Error', 'Failed to retrieve user role. Please try again.');
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
