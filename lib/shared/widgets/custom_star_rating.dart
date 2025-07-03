import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // contoh: 4.5
  final double iconSize;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.iconSize = 20,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(Icon(Icons.star, color: color, size: iconSize));
      } else if (i - rating <= 0.5) {
        stars.add(Icon(Icons.star_half, color: color, size: iconSize));
      } else {
        stars.add(Icon(Icons.star_border, color: color, size: iconSize));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
