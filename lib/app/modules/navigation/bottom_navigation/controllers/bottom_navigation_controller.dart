import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['currentIndex'] != null) {
      currentIndex.value = args['currentIndex'];
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
