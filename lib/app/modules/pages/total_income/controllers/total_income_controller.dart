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

  // MOVIE DATA
  List<String> movieTitles = ["Jumbo", "Giganto", "Tyranno"];

  List<String> dailyMovieTicket = ["500", "320", "400"];
  List<int> dailyMovieIncome = [9000000, 5200000, 8000000];

  List<String> weeklyMovieTicket = ["900", "1100", "850"];
  List<int> weeklyMovieIncome = [18000000, 25000000, 17000000];

  List<String> monthlyMovieTicket = ["2000", "1700", "1800"];
  List<int> monthlyMovieIncome = [40000000, 33000000, 36000000];

  List<String> yearlyMovieTicket = ["8000", "7800", "8200"];
  List<int> yearlyMovieIncome = [160000000, 156000000, 164000000];

  List<String> movieImage = [
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
    "assets/images/jumbo-poster.png",
  ];

  // === FlSpot dari income ===
  List<FlSpot> get dailySpots => List.generate(
    dailyMovieIncome.length,
    (index) => FlSpot(index.toDouble(), dailyMovieIncome[index] / 1000000),
  );

  List<FlSpot> get weeklySpots => List.generate(
    weeklyMovieIncome.length,
    (index) => FlSpot(index.toDouble(), weeklyMovieIncome[index] / 1000000),
  );

  List<FlSpot> get monthlySpots => List.generate(
    monthlyMovieIncome.length,
    (index) => FlSpot(index.toDouble(), monthlyMovieIncome[index] / 1000000),
  );

  List<FlSpot> get yearlySpots => List.generate(
    yearlyMovieIncome.length,
    (index) => FlSpot(index.toDouble(), yearlyMovieIncome[index] / 1000000),
  );

  // === DateTime list ===
  List<DateTime> dailyDates = [
    DateTime(2025, 7, 15),
    DateTime(2025, 7, 16),
    DateTime(2025, 7, 17),
  ];

  List<DateTime> weeklyDates = [
    DateTime(2025, 7, 1),
    DateTime(2025, 7, 8),
    DateTime(2025, 7, 15),
  ];

  List<DateTime> monthlyDates = [
    DateTime(2025, 5),
    DateTime(2025, 6),
    DateTime(2025, 7),
  ];

  List<DateTime> yearlyDates = [DateTime(2022), DateTime(2023), DateTime(2024)];

  // === Bottom Labels from DateTime ===
  Map<int, String> get dailyBottomLabels {
    return Map.fromEntries(
      dailyDates.asMap().entries.map(
        (e) => MapEntry(
          e.key,
          DateFormat.E('id_ID').format(e.value),
        ), // Sen, Sel...
      ),
    );
  }

  Map<int, String> get weeklyBottomLabels {
    return Map.fromEntries(
      weeklyDates.asMap().entries.map(
        (e) => MapEntry(
          e.key,
          DateFormat("d MMM", 'id_ID').format(e.value),
        ), // 1 Jul
      ),
    );
  }

  Map<int, String> get monthlyBottomLabels {
    return Map.fromEntries(
      monthlyDates.asMap().entries.map(
        (e) => MapEntry(
          e.key,
          DateFormat.MMM('id_ID').format(e.value),
        ), // Mei, Jun
      ),
    );
  }

  Map<int, String> get yearlyBottomLabels {
    return Map.fromEntries(
      yearlyDates.asMap().entries.map(
        (e) => MapEntry(e.key, DateFormat.y('id_ID').format(e.value)), // 2022
      ),
    );
  }

  // === Left Labels Manual ===
  Map<int, String> dailyLeftLabels = {5: '5JT', 8: '8JT', 10: '10JT'};
  Map<int, String> weeklyLeftLabels = {15: '15JT', 20: '20JT', 25: '25JT'};
  Map<int, String> monthlyLeftLabels = {30: '30JT', 40: '40JT', 50: '50JT'};
  Map<int, String> yearlyLeftLabels = {
    150: '150JT',
    160: '160JT',
    170: '170JT',
  };

  // === CURRENT SELECTED ===
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

  double get currentMaxY {
    switch (selectedValue.value) {
      case 'Weekly':
        return 30.0;
      case 'Monthly':
        return 50.0;
      case 'Yearly':
        return 180.0;
      default:
        return 12.0; // Untuk Daily
    }
  }

  int get totalTickets {
    return currentMovieTicket.fold(0, (sum, item) => sum + int.parse(item));
  }

  int get totalIncome {
    return currentMovieIncome.fold(0, (sum, item) => sum + item);
  }

  List<Map<String, dynamic>> get currentMovies {
    return List.generate(movieTitles.length, (index) {
      return {
        'movieTitle': movieTitles[index],
        'income': currentMovieIncome[index],
        'ticket': currentMovieTicket[index],
      };
    });
  }
}
