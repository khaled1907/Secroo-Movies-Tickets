import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:flutter/material.dart';

class CinemaCard extends StatelessWidget {
  final String logoPath;
  final String name;
  final String distance;
  final String status;
  final double rating;

  const CinemaCard({
    required this.logoPath,
    required this.name,
    required this.distance,
    required this.status,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColores.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                logoPath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColores.primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 2),
                      Text(
                        distance,
                        style: AppTextStyels.primaryColor_14_bold_400
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text(
                  rating.toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
