import 'package:final_project/Network/api_respone.dart';
import 'package:final_project/Network/api_services.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/features/details/details.dart';
import 'package:final_project/Network/app_results.dart';
import 'package:final_project/features/home/widgets/app_bar.dart';
import 'package:final_project/features/home/widgets/cinema_near.dart';
import 'package:final_project/features/home/widgets/comming_soon.dart';
import 'package:final_project/features/home/widgets/search.dart';
import 'package:final_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? error;
  List<Movie>? movieList;
  bool isLoading = true;
  Map<String, dynamic>? userDetails;
  @override
  void initState() {
    super.initState();
    fetchProducts();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    userDetails = await SharedPreferencesClass.getUserDetails();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final result = await AppServices.instance.getUpComing();

    if (result is ApiSuccess<List<Movie>>) {
      setState(() {
        movieList = result.data;
        isLoading = false;
      });
    } else if (result is ApiFailure<List<Movie>>) {
      setState(() {
        // print(result.exception.message);
        error = result.exception.message;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: MyCustomAppBar(name: userDetails?['name'] ?? "Guest"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchTextField(),
              const SizedBox(height: 30),
              Text("Coming Soon", style: AppTextStyels.white_20_SemiBold),
              const SizedBox(height: 10),
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (error != null)
                Center(
                  child: Text(
                    'Error:  $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (movieList == null || movieList!.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No upcoming movies found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList!.length,
                    itemBuilder: (context, index) {
                      final movie = movieList![index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FilmDetails(movie: movie),
                              ),
                            );
                          },
                          child: CommingSoon(
                            title: movie.title,
                            posterPath: movie.posterPath ?? "",
                            releaseDate: movie.releaseDate ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cinema Near You",
                    style: AppTextStyels.white_20_SemiBold,
                  ),
                  Text("See All", style: AppTextStyels.hint_14_bold_300),
                ],
              ),
              CinemaCard(
                name: "Viva Cinema",
                distance: "5.5 kilometers",
                logoPath: "assets/icons/cinema.png",
                status: "Closed At 10:00",
                rating: 4.5,
              ),
              CinemaCard(
                name: "Viva Cinema",
                distance: "5.5 kilometers",
                logoPath: "assets/icons/cinema2.png",
                status: "Closed At 10:00",
                rating: 4.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
