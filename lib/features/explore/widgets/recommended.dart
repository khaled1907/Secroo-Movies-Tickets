import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/sharedWidgets/rating_stars.dart';
import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  const Recommended({
    super.key,
    required this.posterPath,
    required this.title,
    required this.rating,
    required this.size,
    required this.color,
  });
  final String posterPath, title;
  final double rating;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final fullPosterPath = posterPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : 'https://via.placeholder.com/300x450.png?text=No+Image';

    return Card(
      color: AppColores.backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black45),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 3 / 3,
              child: Image.network(
                fullPosterPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyels.white_20_SemiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: StarRating(
              rating: rating,
              color: color,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}
