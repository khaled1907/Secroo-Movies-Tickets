import 'package:final_project/Network/api_respone.dart';
import 'package:final_project/Network/api_services.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/features/details/details.dart';
import 'package:final_project/features/explore/widgets/app_bar.dart';
import 'package:final_project/features/explore/widgets/recommended.dart';
import 'package:final_project/features/explore/widgets/top_movies.dart';
import 'package:final_project/Network/app_results.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool isNowShowing = true;
  String? error;
  List<Movie>? movieList;
  List<Movie>? recommendedMovieList;
  bool isLoadingNowPlaying = true;
  bool isLoadingRecommended = true;

  @override
  void initState() {
    super.initState();
    FetchUpcomingAndNowPlaying();
    FetchRecommended();
  }

  Future<void> FetchUpcomingAndNowPlaying() async {
    setState(() {
      isLoadingNowPlaying = true;
      error = null;
    });

    final result = isNowShowing
        ? await AppServices.instance.NowPlayingComing()
        : await AppServices.instance.getUpComing();

    if (result is ApiSuccess<List<Movie>>) {
      setState(() {
        movieList = result.data;
        isLoadingNowPlaying = false;
      });
    } else if (result is ApiFailure<List<Movie>>) {
      setState(() {
        error = result.exception.message;
        isLoadingNowPlaying = false;
      });
    }
  }

  Future<void> FetchRecommended() async {
    setState(() {
      isLoadingRecommended = true;
      error = null;
    });

    final result = await AppServices.instance.recommended();

    if (result is ApiSuccess<List<Movie>>) {
      setState(() {
        recommendedMovieList = result.data;
        isLoadingRecommended = false;
      });
    } else if (result is ApiFailure<List<Movie>>) {
      setState(() {
        error = result.exception.message;
        isLoadingRecommended = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExpolreAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColores.grayColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleButtons(
                      constraints: BoxConstraints(minHeight: 60, minWidth: 155),
                      borderWidth: 0,
                      borderRadius: BorderRadius.circular(12),
                      fillColor: AppColores.primaryColor,
                      selectedColor: Colors.white,
                      color: Colors.white,
                      isSelected: [isNowShowing, !isNowShowing],
                      onPressed: (index) {
                        setState(
                          () {
                            isNowShowing = index == 0;
                          },
                        );
                        FetchUpcomingAndNowPlaying();
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Now Showing'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Upcoming'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isLoadingRecommended || isLoadingNowPlaying)
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      kBottomNavigationBarHeight,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (error != null)
                Center(child: Text('Error: $error'))
              else if (movieList == null || movieList!.isEmpty)
                const Center(child: Text('No movies found'))
              else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Top Movies", style: AppTextStyels.white_20_SemiBold),
                    Text("See All", style: AppTextStyels.hint_14_bold_300),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList!.length,
                    itemBuilder: (context, index) {
                      final movie = movieList![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FilmDetails(movie: movie),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TopMovies(
                            title: movie.title,
                            posterPath: movie.posterPath ?? "",
                            rating: movie.voteAverage / 2,
                            color: AppColores.starColor,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recommended", style: AppTextStyels.white_20_SemiBold),
                    Text("See All", style: AppTextStyels.hint_14_bold_300),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedMovieList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = recommendedMovieList![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FilmDetails(movie: movie),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 200,
                          child: Recommended(
                            title: movie.title,
                            posterPath: movie.posterPath ?? "",
                            rating: movie.voteAverage / 2,
                            color: AppColores.starColor,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
