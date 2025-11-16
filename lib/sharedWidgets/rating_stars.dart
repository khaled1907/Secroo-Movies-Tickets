import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 24,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < fullStars; i++)
          Icon(Icons.star, color: color, size: size),
        if (hasHalfStar) Icon(Icons.star_half, color: color, size: size),
        for (var i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: color, size: size),
      ],
    );
  }
}
