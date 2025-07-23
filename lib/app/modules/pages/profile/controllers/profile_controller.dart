import 'package:chingu_app/app/controller/storage_service_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final storageService = Get.find<StorageService>();
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;

  Future<void> getFullName() async {
    final savedName = await storageService.getFullName();
    if (savedName != null) {
      fullName.value = savedName;
    } else {
      fullName.value = 'Guest';
    }
  }

  Future<void> getEmail() async {
    final savedEmail = await storageService.getEmail();
    if (savedEmail != null) {
      email.value = savedEmail;
    } else {
      email.value = 'Guest@gmail.com';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Logout Error', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFullName();
    getEmail();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
