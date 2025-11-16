class AppConstans {
  AppConstans._();
  static const String baseUrl = "https://api.themoviedb.org/";
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxN2QwN2M1ZDI5MzMwMWFmYjcwMjMyNDQ1NWI2MmZhNSIsIm5iZiI6MTc2MjY0MjQ0Ny45MjMsInN1YiI6IjY5MGZjYTBmMDhhNmYxZWY2NjMxYWM2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iHbaM6uUPogaiRks5e4jd1ThEJWheX71MsGydgy3rWU';
  static const String upComingFilms = "3/movie/upcoming?language=en-US&page=1";
  static const String nowPlayingFilms =
      "3/movie/now_playing?language=en-US&page=1";
  static const String recommended = "3/movie/top_rated?language=en-US&page=1";

  static const String baseUrlSeats =
      "https://6912fb9252a60f10c82384c3.mockapi.io/movies";

  static const String baseUrlUsers =
      "https://6912fb9252a60f10c82384c3.mockapi.io/users";
}
