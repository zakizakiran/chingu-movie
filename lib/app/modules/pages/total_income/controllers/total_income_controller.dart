import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalIncomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool showAvg = false.obs;
  RxString selectedValue = 'Daily'.obs;
  RxInt selectedIndex = 0.obs;

  // Firestore data
  RxList<Map<String, dynamic>> firestoreData = <Map<String, dynamic>>[].obs;

  void onIndexChanged(int index) {
    selectedIndex.value = index;
    selectedValue.value = ['Daily', 'Weekly', 'Monthly', 'Yearly'][index];
    fetchFirestoreData();
  }

  void onDropdownChanged(String? value) {
    if (value != null) {
      selectedValue.value = value;
      fetchFirestoreData();
    }
  }

  Future<void> fetchFirestoreData() async {
    try {
      // Fetch tickets data based on the selected type
      final ticketsSnapshot =
          await _firestore
              .collection('tickets')
              .where('type', isEqualTo: selectedValue.value.toLowerCase())
              .get();

      final ticketsData =
          ticketsSnapshot.docs.map((doc) => doc.data()).toList();

      // Fetch movies data
      final moviesSnapshot = await _firestore.collection('movies').get();
      final moviesData = {
        for (var doc in moviesSnapshot.docs) doc.id: doc.data(),
      };

      // Merge tickets and movies data
      firestoreData.value =
          ticketsData.map((ticket) {
            final movieId = ticket['movieId'];
            final movie = moviesData[movieId] ?? {};

            return {
              'movieTitle': movie['title'] ?? 'Unknown',
              'income': ticket['income'] ?? 0,
              'ticket': ticket['ticketCount'] ?? 0,
            };
          }).toList();

      updateChartData();
    } catch (e) {
      print('Error fetching Firestore data: $e');
    }
  }

  void updateChartData() {
    if (firestoreData.isEmpty) return;

    movieTitles =
        firestoreData.map((data) => data['movieTitle'] as String).toList();
    currentMovieIncome =
        firestoreData.map((data) => data['income'] as int).toList();
    currentMovieTicket =
        firestoreData.map((data) => data['ticket'].toString()).toList();

    update();
  }

  // Replace static data with dynamic data
  List<String> movieTitles = [];
  List<int> currentMovieIncome = [];
  List<String> currentMovieTicket = [];

  // === FlSpot dari income ===
  List<FlSpot> get dailySpots => List.generate(
    currentMovieIncome.length,
    (index) => FlSpot(index.toDouble(), currentMovieIncome[index] / 1000000),
  );

  List<FlSpot> get weeklySpots => List.generate(
    currentMovieIncome.length,
    (index) => FlSpot(index.toDouble(), currentMovieIncome[index] / 1000000),
  );

  List<FlSpot> get monthlySpots => List.generate(
    currentMovieIncome.length,
    (index) => FlSpot(index.toDouble(), currentMovieIncome[index] / 1000000),
  );

  List<FlSpot> get yearlySpots => List.generate(
    currentMovieIncome.length,
    (index) => FlSpot(index.toDouble(), currentMovieIncome[index] / 1000000),
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
  List<int> get dynamicMovieIncome =>
      firestoreData.map((data) => data['income'] as int).toList();

  List<String> get dynamicMovieTicket =>
      firestoreData.map((data) => data['ticket'].toString()).toList();

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

  List<String> get movieImage =>
      firestoreData.map((data) {
        return (data['image'] ?? 'assets/images/jumbo-poster.png') as String;
      }).toList();

  List<FlSpot> get currentSpots {
    return firestoreData.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        (entry.value['income'] as int) / 1000000,
      );
    }).toList();
  }

  Map<int, String> get currentBottomLabels {
    return firestoreData.asMap().map((index, data) {
      return MapEntry(index, data['movieTitle'] as String);
    });
  }

  Map<int, String> get currentLeftLabels {
    return {5: '5JT', 10: '10JT', 15: '15JT'}; // Example static labels
  }
}
