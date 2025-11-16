import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  final String posterPath, title, releaseDate;

  CommingSoon({
    super.key,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    final fullPosterPath = 'https://image.tmdb.org/t/p/w500$posterPath';
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8;
    final cardHeight = cardWidth * 1.5;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        color: AppColores.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 5),
              child: Text(
                releaseDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                fullPosterPath,
                width: double.infinity,
                height: cardHeight * 0.65,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyels.white_20_SemiBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    releaseDate,
                    style: AppTextStyels.hint_14_bold_400
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
