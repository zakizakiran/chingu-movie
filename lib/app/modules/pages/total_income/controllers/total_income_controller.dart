import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class TotalIncomeController extends GetxController {
  //TODO: Implement TotalIncomeController
  RxBool showAvg = false.obs;
  RxString selectedValue = 'Daily'.obs;

  // Dummy data untuk grafik
  RxList<FlSpot> spots = <FlSpot>[].obs;

  // Label sumbu X (hari, bulan)
  RxMap<int, String> bottomAxisLabels = <int, String>{}.obs;

  // Label sumbu Y (jumlah uang)
  RxMap<int, String> leftAxisLabels = <int, String>{}.obs;

  final RxInt selectedIndex = 0.obs;

  void onIndexChanged(int index) {
    selectedIndex.value = index;
    selectedValue.value = ['Daily', 'Weekly', 'Monthly', 'Yearly'][index];
  }

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void onDropdownChanged(String? value) {
    if (value != null) {
      selectedValue.value = value;
      loadDummyData(); // ubah dari firebase
    }
  }

  void loadDummyData() {
    // Dummy titik grafik
    spots.value = [
      FlSpot(0, 3),
      FlSpot(1, 2.5),
      FlSpot(2, 1.5),
      FlSpot(3, 3.5),
      FlSpot(4, 2.2),
      FlSpot(5, 4),
      FlSpot(6, 3.8),
    ];

    // Label sumbu X (senin-minggu)
    bottomAxisLabels.value = {
      0: 'Mon',
      1: 'Tue',
      2: 'Wed',
      3: 'Thu',
      4: 'Fri',
      5: 'Sat',
      6: 'Sun',
    };

    // Label sumbu Y (total uang)
    leftAxisLabels.value = {1: '10K', 3: '30K', 5: '50K'};
  }

  final count = 0.obs;

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
