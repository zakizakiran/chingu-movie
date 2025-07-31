import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ListMovieController extends GetxController {
  final searchController = TextEditingController();

  // Studio
  final selectedStudioIndex = 0.obs;
  final RxList<String> studios = <String>[].obs;

  // Movie data
  var movieList = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get filteredMovies {
    if (studios.isEmpty) return [];
    final selectedStudio = studios[selectedStudioIndex.value];
    return movieList
        .where((movie) => movie["studio"] == selectedStudio)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMoviesFromFirestore();
  }

  Future<void> fetchMoviesFromFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('movies').get();

      final movies =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              "movie_id": doc.id,
              "imagePath": data["poster_url"],
              "title": data["title"] ?? "Unknown Title",
              "studio": data["studio"] ?? "Unknown Studio",
              "date": data["release_date"] ?? "Unknown Date",
            };
          }).toList();

      movieList.value =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              "movie_id": doc.id,
              "title": data["title"],
              "studio": data["studio"],
              "poster_url": data["poster_url"], // ganti nama key agar konsisten
              "release_date": data["release_date"],
              "synopsis": data["synopsis"],
              "price": data["price"],
              "genre": data["genre"],
              "duration": data["duration"],
              "imagePath": data["poster_url"], // untuk tampilan di list
            };
          }).toList();

      // Dapatkan semua studio unik
      final uniqueStudios =
          movies.map((m) => m["studio"].toString()).toSet().toList();
      studios.assignAll(uniqueStudios);
      selectedStudioIndex.value = 0;
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  Future<void> deleteMovieById(String movieId) async {
    try {
      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movieId)
          .delete();
      movieList.removeWhere((movie) => movie["movie_id"] == movieId);
      Get.snackbar(
        "Success",
        "Movie deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Error deleting movie: $e");
      Get.snackbar(
        "Error",
        "Failed to delete movie",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
