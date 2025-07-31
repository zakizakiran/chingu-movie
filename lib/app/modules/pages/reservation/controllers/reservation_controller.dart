import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum SeatStatus { available, reserved, selected }

class SeatBlock {
  final String name;
  final int rows;
  final int cols;
  final List<List<Rx<SeatStatus>>> seats;

  SeatBlock(this.name, this.rows, this.cols)
    : seats = List.generate(
        rows,
        (_) => List.generate(cols, (_) => SeatStatus.available.obs),
      );
}

class ReservationController extends GetxController {
  final blocks =
      <SeatBlock>[
        SeatBlock('Left', 4, 3),
        SeatBlock('Center', 5, 6),
        SeatBlock('Right', 4, 3),
      ].obs;

  /// Toggle kursi antara 'available' dan 'selected'
  void toggleSeat(int blockIndex, int row, int col) {
    final seat = blocks[blockIndex].seats[row][col];
    if (seat.value == SeatStatus.available) {
      seat.value = SeatStatus.selected;
    } else if (seat.value == SeatStatus.selected) {
      seat.value = SeatStatus.available;
    }
  }

  /// Konfirmasi pemesanan dengan mengubah kursi yang dipilih jadi 'reserved'
  void confirmBooking() {
    for (final block in blocks) {
      for (final row in block.seats) {
        for (final seat in row) {
          if (seat.value == SeatStatus.selected) {
            seat.value = SeatStatus.reserved;
          }
        }
      }
    }
  }

  /// Ambil label kursi yang sedang dipilih (selected)
  List<String> get selectedSeatLabels {
    final selectedSeats = <String>[];
    for (var i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      for (var row = 0; row < block.rows; row++) {
        for (var col = 0; col < block.cols; col++) {
          if (block.seats[row][col].value == SeatStatus.selected) {
            selectedSeats.add('${block.name[0]}${row + 1}${col + 1}');
          }
        }
      }
    }
    return selectedSeats;
  }

  Future<void> loadReservedSeats(String movieTitle, String showtime) async {
    try {
      // 🧹 Step 1: Reset semua kursi jadi available
      for (var block in blocks) {
        for (var row in block.seats) {
          for (var seat in row) {
            seat.value = SeatStatus.available;
          }
        }
      }

      // 🧲 Step 2: Ambil data kursi yang dibooking dari Firestore
      final snapshot =
          await FirebaseFirestore.instance
              .collection('tickets')
              .where('movie_title', isEqualTo: movieTitle)
              .where('showtime', isEqualTo: showtime)
              .where('status', isEqualTo: 'active')
              .get();

      final reservedSeats = <String>[];

      for (var doc in snapshot.docs) {
        final seats = List<String>.from(doc['selected_seats'] ?? []);
        reservedSeats.addAll(seats);
      }

      // 🧷 Step 3: Tandai kursi yang dibooking jadi reserved
      for (var block in blocks) {
        for (var row = 0; row < block.rows; row++) {
          for (var col = 0; col < block.cols; col++) {
            final label = '${block.name[0]}${row + 1}${col + 1}';
            if (reservedSeats.contains(label)) {
              block.seats[row][col].value = SeatStatus.reserved;
            }
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load reserved seats: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Reset semua kursi jadi 'available'
  void resetAllSeats() {
    for (final block in blocks) {
      for (final row in block.seats) {
        for (final seat in row) {
          seat.value = SeatStatus.available;
        }
      }
    }
  }

  @override
  void onClose() {
    // Bersihkan atau reset data jika perlu\
    blocks.clear();
    super.onClose();
  }
}
