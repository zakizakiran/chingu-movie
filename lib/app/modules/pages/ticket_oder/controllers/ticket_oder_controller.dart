import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TicketOrderController extends GetxController {
  final RxList<Map<String, dynamic>> tickets = <Map<String, dynamic>>[].obs;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final isLoading = false.obs;

  late final Stream<QuerySnapshot<Map<String, dynamic>>> _ticketStream;

  @override
  void onInit() {
    super.onInit();
    _listenToTickets();
  }

  void _listenToTickets() {
    _ticketStream =
        FirebaseFirestore.instance
            .collection('tickets')
            .orderBy('created_at', descending: true)
            .snapshots();

    _ticketStream.listen((snapshot) {
      final result =
          snapshot.docs.map((doc) {
            final data = doc.data();
            data['ticket_id'] = doc.id; // agar bisa dipakai update
            return data;
          }).toList();

      tickets.value = result;
    });
  }

  List<Map<String, dynamic>> get filteredTickets {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) return tickets;

    return tickets.where((ticket) {
      final title = (ticket['movie_title'] ?? '').toString().toLowerCase();
      final pid = (ticket['payment_id'] ?? '').toString().toLowerCase();
      final status = (ticket['status'] ?? '').toString().toLowerCase();
      return title.contains(query) ||
          pid.contains(query) ||
          status.contains(query);
    }).toList();
  }

  Future<void> acceptPayment(String ticketId) async {
    try {
      isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('tickets')
          .doc(ticketId)
          .update({'status': 'active'});
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
