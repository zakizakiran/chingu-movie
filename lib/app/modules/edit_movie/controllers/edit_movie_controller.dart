import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMovieController extends GetxController {
  final titleController = TextEditingController();
  final synopsisController = TextEditingController();
  final priceController = TextEditingController();

  var selectedGenre = ''.obs;
  var selectedDate = ''.obs;
  var selectedDuration = ''.obs;
  var selectedImage = Rx<File?>(null);
  var isLoading = false.obs;

  late String movieId; // <- id dokumen Firestore
  late String? oldPosterUrl;

  void initMovieData(Map<String, dynamic> movieData, String id) {
    movieId = id;
    oldPosterUrl = movieData['poster_url'];
    titleController.text = movieData['title'] ?? '';
    synopsisController.text = movieData['synopsis'] ?? '';
    priceController.text = movieData['price']?.toString() ?? '';
    selectedGenre.value = movieData['genre'] ?? '';
    selectedDate.value = movieData['release_date'] ?? '';
    selectedDuration.value = movieData['duration'] ?? '';
  }

  Future<void> editMovie() async {
    isLoading.value = true;

    try {
      String? posterUrl = oldPosterUrl;

      // Jika user pilih gambar baru
      if (selectedImage.value != null) {
        // Upload ke Cloudinary / Firebase Storage
        // Ganti dengan fungsi upload milikmu
        posterUrl = await _uploadToCloudinary(selectedImage.value!);
      }

      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movieId)
          .update({
            'title': titleController.text.trim(),
            'synopsis': synopsisController.text.trim(),
            'price': priceController.text.trim(),
            'genre': selectedGenre.value,
            'release_date': selectedDate.value,
            'duration': selectedDuration.value,
            'poster_url': posterUrl,
          });

      Get.back(); // kembali ke halaman sebelumnya
      Get.snackbar("Success", "Movie updated successfully");
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to update movie");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _uploadToCloudinary(File imageFile) async {
    const cloudName = 'dqjqeszwa';
    const uploadPreset = 'ml_default';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..files.add(
            await http.MultipartFile.fromPath('file', imageFile.path),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final data = json.decode(body);
      return data['secure_url'];
    } else {
      throw Exception('Failed to upload image to Cloudinary');
    }
  }
}
