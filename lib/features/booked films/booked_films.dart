import 'package:final_project/Network/api_booked.dart';
import 'package:final_project/Network/api_services.dart';
import 'package:final_project/Network/app_results.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class BookedFilms extends StatefulWidget {
  const BookedFilms({super.key});

  @override
  State<BookedFilms> createState() => _BookedFilmsState();
}

class _BookedFilmsState extends State<BookedFilms> {
  Map<String, dynamic>? userDetails;
  List<MovieBokked> userMovies = [];
  String? error;
  bool isLoading = true;

  @override
  void initState() {
    getUserDetailsAndLoadMovies();
    super.initState();
  }

  Future<void> getUserDetailsAndLoadMovies() async {
    try {
      userDetails = await SharedPreferencesClass.getUserDetails();
      final userId = userDetails?['id'];

      if (userId == null) {
        setState(() {
          error = "User ID not found";
          isLoading = false;
        });
        return;
      }

      final result =
          await AppServices.instance.fetchUserMovies(userId.toString());

      setState(() {
        if (result is ApiSuccess<List<MovieBokked>>) {
          userMovies = result.data;
          if (userMovies.isEmpty) {
            error = "You haven't booked any movies yet.";
          }
        } else if (result is ApiFailure<List<MovieBokked>>) {
          error = result.exception.message;
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("YOUR BOOKED FILMS", style: AppTextStyels.white_20_SemiBold),
        backgroundColor: AppColores.backgroundColor,
      ),
      backgroundColor: AppColores.backgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: error != null
                  ? Center(
                      child: Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: userMovies.length,
                        itemBuilder: (context, index) {
                          final movie = userMovies[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColores.hintColor,
                                    AppColores.primaryColor
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Icon(
                                        Icons.movie,
                                        color: Colors.white70,
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      movie.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Nasr City at 11:00 PM",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Seats :',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    movie.seats.isNotEmpty
                                        ? Center(
                                            child: Wrap(
                                              spacing: 6,
                                              runSpacing: 6,
                                              children: movie.seats
                                                  .map((seat) => Chip(
                                                        label: Text(seat),
                                                        backgroundColor:
                                                            Colors.black12,
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ))
                                                  .toList(),
                                            ),
                                          )
                                        : const Text(
                                            "No seats info",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
    );
  }
}
