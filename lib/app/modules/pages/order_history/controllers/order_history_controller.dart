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

  void listenToTickets() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    isLoading.value = true;

    // Langganan perubahan data tiket
    FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) async {
          final ticketDocs = snapshot.docs;

          final movieSnapshot =
              await FirebaseFirestore.instance.collection('movies').get();
          final movieMap = {
            for (var doc in movieSnapshot.docs) doc['title']: doc['poster_url'],
          };

          final result =
              ticketDocs.map((doc) {
                final data = doc.data();
                final title = data['movie_title'] ?? '';
                final imageUrl = movieMap[title] ?? '';
                return {...data, 'image_url': imageUrl};
              }).toList();

          tickets.assignAll(result);
          filterTickets(searchController.text);

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
