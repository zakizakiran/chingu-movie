import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final tickets = <Map<String, dynamic>>[].obs;
  final filteredTickets = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    listenToTickets();
  }

  void listenToTickets() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
          final result = snapshot.docs.map((doc) => doc.data()).toList();
          tickets.assignAll(result);
          filterTickets(searchController.text);

          // setelah data diterima, loading selesai
          isLoading.value = false;
        });
  }

  void filterTickets(String query) {
    if (query.isEmpty) {
      filteredTickets.assignAll(tickets);
    } else {
      final filtered =
          tickets.where((ticket) {
            final title = ticket['movie_title']?.toString().toLowerCase() ?? '';
            return title.contains(query.toLowerCase());
          }).toList();
      filteredTickets.assignAll(filtered);
    }
  }
}
