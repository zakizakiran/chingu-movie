// ignore_for_file: file_names

class Ticket {
  final String ticketId;
  final String userId;
  final String movieTitle;
  final String showtime;
  final List<String> selectedSeats;
  final int price;
  final int totalPrice;

  Ticket({
    required this.ticketId,
    required this.userId,
    required this.movieTitle,
    required this.showtime,
    required this.selectedSeats,
    required this.price,
    required this.totalPrice,
  });

  Map<String, dynamic> toFirestoreMap() {
    return {
      'ticketId': ticketId,
      'user_id': userId,
      'movie_title': movieTitle,
      'showtime': showtime,
      'selected_seats': selectedSeats,
      'price': price,
      'total_price': totalPrice,
    };
  }
}
