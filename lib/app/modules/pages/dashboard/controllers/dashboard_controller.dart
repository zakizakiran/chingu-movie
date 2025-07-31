import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  var movieTitle = <String>[].obs;
  var totalTicket = <double>[].obs;

  var value = <String>[].obs;
  final title = ["Ticket Sold Out", "Movie"];
  final information = ["This Month", "Active"];
  var income = '0'.obs;
  String? date;

  @override
  void onInit() {
    super.onInit();
    date = DateFormat('MMMM yyyy').format(DateTime.now());
    fetchTicketData();
    fetchIncome();

    ever(movieTitle, (_) => updateValue());
    ever(totalTicket, (_) => updateValue());
  }

  void updateValue() {
    value.assignAll([
      '${totalTicket.fold(0.0, (a, b) => a + b).toInt()}',
      '${movieTitle.length}',
    ]);
  }

  void fetchTicketData() {
    FirebaseFirestore.instance.collection('movies').snapshots().listen((
      snapshot,
    ) {
      final titles =
          snapshot.docs
              .map((doc) => doc['title']?.toString() ?? 'Unknown')
              .toList();
      movieTitle.assignAll(titles);

      final ticketMap = <String, double>{};
      for (final title in titles) {
        ticketMap[title] = 0.0;
      }

      FirebaseFirestore.instance.collection('tickets').get().then((
        ticketSnapshot,
      ) {
        for (var doc in ticketSnapshot.docs) {
          final title = doc['movie_title'] ?? 'Unknown';
          if (ticketMap.containsKey(title)) {
            ticketMap[title] = (ticketMap[title] ?? 0) + 1;
          }
        }

        totalTicket.value = ticketMap.values.toList();
      });
    });
  }

  void fetchIncome() {
    FirebaseFirestore.instance
        .collection('tickets')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .listen((snapshot) {
          final total = snapshot.docs.fold<int>(
            0,
            (sum, doc) => sum + ((doc['total_price'] ?? 0) as int),
          );
          income.value = NumberFormat('#,###', 'id_ID').format(total);
        });
  }
}
