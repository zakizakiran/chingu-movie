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

  void toggleSeat(int blockIndex, int row, int col) {
    final seat = blocks[blockIndex].seats[row][col];
    if (seat.value == SeatStatus.available) {
      seat.value = SeatStatus.selected;
    } else if (seat.value == SeatStatus.selected) {
      seat.value = SeatStatus.available;
    }
  }

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
}
