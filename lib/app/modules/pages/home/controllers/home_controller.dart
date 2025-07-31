import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();

  final genres = ['All', 'Action', 'Drama', 'Comedy', 'Thriller'].obs;
  final selectedGenre = 'All'.obs;

  final movies = [
    {
      'title': 'Jumbo',
      'genre': 'Comedy',
      'poster': 'assets/images/jumbo-poster.png',
      'synopsis': 'A fun comedy adventure.',
      'year': 2025,
      'duration': '1h 45m',
      'rating': 4.5,
    },
    {
      'title': 'Giganto',
      'genre': 'Action',
      'poster': 'assets/images/jumbo-poster.png',
      'synopsis': 'An epic action tale.',
      'year': 2025,
      'duration': '2h',
      'rating': 3,
    },
    // Tambahkan data film lainnya
  ];

  final filteredMovies = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredMovies.assignAll(movies);
    searchController.addListener(_filterMovies);
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

    filteredMovies.assignAll(result); // ini penting
  }

  void selectGenre(String genre) {
    selectedGenre.value = genre;
    _filterMovies();
  }
}
