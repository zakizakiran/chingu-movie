import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  // MOVIE DATA
  List<String> dailyMovieTitle = ["Jumbo", "Harry Potter", "Moving"];
  List<String> dailyMovieTicket = ["500", "320", "400"];
  List<int> dailyMovieIncome = [9000000, 5200000, 8000000];

  List<String> weeklyMovieTitle = ["Barbie", "Avengers", "Interstellar"];
  List<String> weeklyMovieTicket = ["900", "1100", "850"];
  List<int> weeklyMovieIncome = [18000000, 25000000, 17000000];

  List<String> monthlyMovieTitle = ["Oppenheimer", "Dune", "Wonka"];
  List<String> monthlyMovieTicket = ["2000", "1700", "1800"];
  List<int> monthlyMovieIncome = [40000000, 33000000, 36000000];

  List<String> yearlyMovieTitle = ["Fast X", "Tenet", "Inception"];
  List<String> yearlyMovieTicket = ["8000", "7800", "8200"];
  List<int> yearlyMovieIncome = [160000000, 156000000, 164000000];

  List<String> movieImage = [
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
  ];

  List<String> get currentMovieTitle {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklyMovieTitle;
      case 'Monthly':
        return monthlyMovieTitle;
      case 'Yearly':
        return yearlyMovieTitle;
      default:
        return dailyMovieTitle;
    }
  }

  List<String> get currentMovieTicket {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklyMovieTicket;
      case 'Monthly':
        return monthlyMovieTicket;
      case 'Yearly':
        return yearlyMovieTicket;
      default:
        return dailyMovieTicket;
    }
  }

  List<int> get currentMovieIncome {
    switch (selectedValue.value) {
      case 'Weekly':
        return weeklyMovieIncome;
      case 'Monthly':
        return monthlyMovieIncome;
      case 'Yearly':
        return yearlyMovieIncome;
      default:
        return dailyMovieIncome;
    }
  }

  int get totalTickets {
    return currentMovieTicket.fold(0, (sum, item) => sum + int.parse(item));
  }

  int get totalIncome {
    return currentMovieIncome.fold(0, (sum, item) => sum + item);
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
