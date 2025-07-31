import 'dart:io';

class Movie {
  final String title;
  final String synopsis;
  final double price;
  final String genre;
  final DateTime releaseDate;
  final File? image;
  final int studio;
  final Duration duration;

  Movie({
    required this.title,
    required this.synopsis,
    required this.price,
    required this.genre,
    required this.releaseDate,
    this.image,
    required this.studio,
    required this.duration,
  });

  Map<String, dynamic> toFirestoreMap() {
    return {
      'title': title,
      'synopsis': synopsis,
      'price': price,
      'genre': genre,
      'release_date': releaseDate,
      'duration': duration,
      'image': image?.path,
      'studio': studio,
    };
  }
}
