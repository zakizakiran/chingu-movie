// Tambahkan import ini jika belum
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class TotalIncomeController extends GetxController {
  RxBool showAvg = false.obs;

  RxString selectedValue = 'Daily'.obs;
  RxInt selectedIndex = 0.obs;

  void onIndexChanged(int index) {
    selectedIndex.value = index;
    selectedValue.value = ['Daily', 'Weekly', 'Monthly', 'Yearly'][index];
  }

  void onDropdownChanged(String? value) {
    if (value != null) {
      selectedValue.value = value;
    }
  }

  // DAILY
  List<FlSpot> dailySpots = [
    FlSpot(0, 3),
    FlSpot(1, 2.5),
    FlSpot(2, 1.5),
    FlSpot(3, 3.5),
    FlSpot(4, 2.2),
    FlSpot(5, 4),
    FlSpot(6, 3.8),
  ];
  Map<int, String> dailyBottomLabels = {
    0: 'Mon',
    1: 'Tue',
    2: 'Wed',
    3: 'Thu',
    4: 'Fri',
    5: 'Sat',
    6: 'Sun',
  };
  Map<int, String> dailyLeftLabels = {1: '10K', 3: '30K', 5: '50K'};

  // WEEKLY
  List<FlSpot> weeklySpots = [
    FlSpot(0, 10),
    FlSpot(1, 15),
    FlSpot(2, 8),
    FlSpot(3, 12),
  ];
  Map<int, String> weeklyBottomLabels = {0: 'W1', 1: 'W2', 2: 'W3', 3: 'W4'};
  Map<int, String> weeklyLeftLabels = {
    5: '50K',
    8: '80K',
    10: '100K',
    12: '120K',
    15: '150K',
  };

  // MONTHLY
  List<FlSpot> monthlySpots = [FlSpot(0, 30), FlSpot(1, 45), FlSpot(2, 60)];
  Map<int, String> monthlyBottomLabels = {0: 'May', 1: 'Jun', 2: 'Jul'};
  Map<int, String> monthlyLeftLabels = {20: '200K', 40: '400K', 60: '600K'};

  // YEARLY
  List<FlSpot> yearlySpots = [FlSpot(0, 300), FlSpot(1, 500), FlSpot(2, 400)];
  Map<int, String> yearlyBottomLabels = {0: '2022', 1: '2023', 2: '2024'};
  Map<int, String> yearlyLeftLabels = {200: '2JT', 400: '4JT', 600: '6JT'};

  List<FlSpot> get spots => currentSpots;

  // Getters
  List<FlSpot> get currentSpots {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklySpots;
      case 'Monthly':
        return monthlySpots;
      case 'Yearly':
        return yearlySpots;
      default:
        return dailySpots;
    }
  }

  Map<int, String> get currentBottomLabels {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklyBottomLabels;
      case 'Monthly':
        return monthlyBottomLabels;
      case 'Yearly':
        return yearlyBottomLabels;
      default:
        return dailyBottomLabels;
    }
  }

  Map<int, String> get currentLeftLabels {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklyLeftLabels;
      case 'Monthly':
        return monthlyLeftLabels;
      case 'Yearly':
        return yearlyLeftLabels;
      default:
        return dailyLeftLabels;
    }
  }

  //=== DATA MOVIE ===
  List<String> movieTitle = ["Jumbo", "Harry Potter", "Moving"];

  List<String> movieTicket = ["500", "320", "400"];

  List<String> movieIncome = [
    "Rp. 9.000.000",
    "Rp. 5.200.000",
    "Rp. 8.000.000",
  ];

  List<String> movieImage = [
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
  ];

  // Menghitung total tiket
  int get totalTickets {
    return movieTicket.fold(0, (sum, item) => sum + int.parse(item));
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
