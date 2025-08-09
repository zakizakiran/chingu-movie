import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final genres = ['All', 'Action', 'Drama', 'Comedy', 'Horror'].obs;
  final selectedGenre = 'All'.obs;

  final movies = <Map<String, dynamic>>[].obs;
  final filteredMovies = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
    searchController.addListener(_filterMovies);
  }

  Future<void> fetchMovies() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('movies')
              .orderBy('created_at', descending: true)
              .get();

      final data = snapshot.docs.map((doc) => doc.data()).toList();
      movies.assignAll(data);
      _filterMovies(); // langsung filter
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch movies: $e");
    }
  }

  void _filterMovies() {
    final query = searchController.text.toLowerCase();
    final genre = selectedGenre.value;

    final result =
        movies.where((movie) {
          final matchesGenre = genre == 'All' || movie['genre'] == genre;
          final matchesSearch =
              (movie['title'] as String?)?.toLowerCase().contains(query) ??
              false;
          return matchesGenre && matchesSearch;
        }).toList();

    filteredMovies.assignAll(result);
  }

  void selectGenre(String genre) {
    selectedGenre.value = genre;
    _filterMovies();
  }
}
