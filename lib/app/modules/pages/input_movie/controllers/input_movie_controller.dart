import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class InputMovieController extends GetxController {
  final titleController = TextEditingController();
  final synopsisController = TextEditingController();
  final priceController = TextEditingController();
  final selectedDuration = "".obs;

  var isLoading = false.obs;
  var selectedGenre = ''.obs;
  var selectedDate = ''.obs;
  var selectedImage = Rx<File?>(null);

  Future<void> insertMovie() async {
    try {
      final title = titleController.text.trim();
      final synopsis = synopsisController.text.trim();
      final price =
          int.tryParse(
            priceController.text.trim().replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      final genre = selectedGenre.value;
      final releaseDate = selectedDate.value;
      final duration = selectedDuration.value;
      final studio = 'Studio ${Random().nextInt(3) + 1}';
      final imageFile = selectedImage.value;

      if ([
            title,
            synopsis,
            genre,
            releaseDate,
            duration,
            studio,
          ].contains('') ||
          imageFile == null ||
          price == 0) {
        Get.snackbar("Error", "Please fill all fields and select image.");
        return;
      }

      final imageUrl = await _uploadToCloudinary(imageFile);

      final movieId = const Uuid().v4();

      await FirebaseFirestore.instance.collection('movies').doc(movieId).set({
        'movie_id': movieId,
        'title': title,
        'synopsis': synopsis,
        'price': price,
        'genre': genre,
        'release_date': releaseDate,
        'duration': duration,
        'studio': studio,
        'poster_url': imageUrl,
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Movie inserted successfully.");
      resetFields();
      Get.offAllNamed('/admin-navigation');
    } catch (e) {
      Get.snackbar("Error", "Failed to insert movie: $e");
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

  void resetFields() {
    titleController.clear();
    synopsisController.clear();
    priceController.clear();
    selectedGenre.value = '';
    selectedDate.value = '';
    selectedImage.value = null;
    selectedDuration.value = '';
  }
}
