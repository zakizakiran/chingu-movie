import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanTicketController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final cameraController = MobileScannerController();
  final isScanned = false.obs;
  final result = ''.obs;
  var isFrontCamera = true.obs;

  final movieTitle = ''.obs;
  final movieStudio = ''.obs;
  final movieShowtime = ''.obs;
  final imagePath = ''.obs;

  final isLoading = false.obs;

  void resetScan() {
    isScanned.value = false;
    result.value = '';
    movieTitle.value = '';
    movieStudio.value = '';
    movieShowtime.value = '';
    imagePath.value = '';
  }

  void toggleCamera() {
    cameraController.switchCamera();
  }

  Future<void> fetchTicketAndMovie(String ticketId) async {
    try {
      isLoading.value = true;

      // Fetch ticket
      final ticketDoc =
          await firestore.collection('tickets').doc(ticketId).get();

      if (!ticketDoc.exists) {
        Get.snackbar('Not Found', 'Ticket not found');
        return;
      }

      final ticketData = ticketDoc.data()!;
      final movieTitleFromTicket = ticketData['movie_title'] ?? '';
      final showtime = ticketData['showtime'] ?? '';
      movieShowtime.value = showtime;
      movieTitle.value = movieTitleFromTicket;
      movieStudio.value = ticketData['studio'] ?? '';

      // Fetch related movie
      final movieSnapshot =
          await firestore
              .collection('movies')
              .where('title', isEqualTo: movieTitleFromTicket)
              .limit(1)
              .get();

      if (movieSnapshot.docs.isNotEmpty) {
        final movieData = movieSnapshot.docs.first.data();
        imagePath.value = movieData['poster_url'] ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load ticket: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
