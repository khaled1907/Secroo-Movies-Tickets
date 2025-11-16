import 'package:final_project/Network/api_respone.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/features/seat%20Select/seat_select.dart';
import 'package:final_project/sharedWidgets/rating_stars.dart';
import 'package:flutter/material.dart';

class FilmDetails extends StatelessWidget {
  final Movie movie;
  const FilmDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    String title = movie.title;
    String originalTitle = movie.originalTitle;
    String posterPath = movie.posterPath != null
        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
        : 'https://via.placeholder.com/300x450.png?text=No+Image';
    String language = movie.originalLanguage;
    double rating = movie.voteAverage;
    int voteCount = movie.voteCount;
    String overview =
        movie.overview.isNotEmpty ? movie.overview : "No description available";
    String releaseDate = movie.releaseDate ?? "18-10-2000";
    bool adult = movie.adult;
    double popularity = movie.popularity;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        backgroundColor: AppColores.backgroundColor,
        title: Text('Movie Details', style: AppTextStyels.white_20_SemiBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    posterPath,
                    fit: BoxFit.cover,
                    width: screenWidth * 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Titles
            Text(title, style: AppTextStyels.white_20_SemiBold),
            const SizedBox(height: 4),
            Text("Original Title: $originalTitle",
                style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 4),
            Text("Language: $language", style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 4),
            Text("Adult: ${adult ? 'Yes' : 'No'}",
                style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 4),
            Text("Popularity: ${popularity.toStringAsFixed(1)}",
                style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 4),
            Text("Votes: $voteCount", style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 12),
            Row(
              children: [
                StarRating(rating: rating, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(rating.toString() + " /10",
                    style: AppTextStyels.hint_14_bold_300),
              ],
            ),
            const SizedBox(height: 12),
            Text('Release Date: $releaseDate',
                style: AppTextStyels.hint_14_bold_300),
            const SizedBox(height: 16),

            Text('Synopsis', style: AppTextStyels.white_20_SemiBold),
            const SizedBox(height: 8),
            Text(
              overview,
              style:
                  AppTextStyels.hint_14_bold_300.copyWith(color: Colors.white),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),

            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColores.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSeatsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Text(
                    "Book Ticket",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
