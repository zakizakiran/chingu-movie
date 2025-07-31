import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailMovieController extends GetxController {
  final selectedShowtimeIndex = (-1).obs;
  final showtimes = <String>[].obs;

  void selectShowtime(int index) {
    selectedShowtimeIndex.value = index;
  }

  void generateShowtimes(String durationText) {
    showtimes.clear();

    // Parse durasi string: "1 hour 30 minute"
    final hourMatch = RegExp(r'(\d+)\s*hour').firstMatch(durationText);
    final minuteMatch = RegExp(r'(\d+)\s*minute').firstMatch(durationText);

    final durationHours = int.tryParse(hourMatch?.group(1) ?? '0') ?? 0;
    final durationMinutes = int.tryParse(minuteMatch?.group(1) ?? '0') ?? 0;

    final duration = Duration(hours: durationHours, minutes: durationMinutes);
    final gap = const Duration(hours: 3); // jeda antar showtime

    // Mulai dari jam 10:00 pagi
    DateTime startTime = DateTime.now().copyWith(hour: 10, minute: 0);

    final formatter = DateFormat('HH:mm');

    for (int i = 0; i < 3; i++) {
      final endTime = startTime.add(duration);

      final rangeText =
          "${formatter.format(startTime)} - ${formatter.format(endTime)}";
      showtimes.add(rangeText);

      // showtime berikutnya dimulai 3 jam setelah showtime sebelumnya dimulai
      startTime = startTime.add(gap);
    }
  }
}
