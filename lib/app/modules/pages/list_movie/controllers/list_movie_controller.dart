import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ListMovieController extends GetxController {
  //TODO: Implement ListMovieController
  final searchController = TextEditingController();

  //===STUDIO DATA===
  final selectedStudioIndex = 0.obs;

  final List<String> studios = ["Studio 1", "Studio 2", "Studio 3"];

  List<Map<String, dynamic>> get filteredMovies {
    final selectedStudio = studios[selectedStudioIndex.value];
    return movieList
        .where((movie) => movie["studio"] == selectedStudio)
        .toList();
  }

  //===MOVIE DATA===
  var movieList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyMovies();
  }

  void loadDummyMovies() {
    movieList.value = [
      {
        "imagePath": "assets/images/jumbo-poster.png",
        "title": "Jumbo",
        "studio": "Studio 1",
        "date": "Thursday, June 26th, 2025",
      },
      {
        "imagePath": "assets/images/jumbo-poster.png",
        "title": "Avatar",
        "studio": "Studio 3",
        "date": "Friday, July 5th, 2025",
      },
      {
        "imagePath": "assets/images/jumbo-poster.png",
        "title": "Harry Potter",
        "studio": "Studio 2",
        "date": "Sunday, July 7th, 2025",
      },
      {
        "imagePath": "assets/images/jumbo-poster.png",
        "title": "Minion",
        "studio": "Studio 2",
        "date": "Sunday, July 7th, 2025",
      },
    ];
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}