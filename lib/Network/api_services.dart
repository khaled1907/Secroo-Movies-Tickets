import 'package:dio/dio.dart';
import 'package:final_project/Network/api_booked.dart';
import 'package:final_project/Network/api_respone.dart';
import 'package:final_project/Network/seats.dart';
import 'package:final_project/Network/app_constans.dart';
import 'package:final_project/Network/app_expetion.dart';
import 'package:final_project/Network/app_results.dart';
import 'package:final_project/Network/dio_config.dart';

class AppServices {
  AppServices._();
  static final AppServices instance = AppServices._();

  Future<ApiResults<List<Movie>>> getUpComing() async {
    try {
      Dio dio = DioConfig.getDio();
      final String url = AppConstans.upComingFilms;
      Response res = await dio.get(url);

      if (res.statusCode == 200) {
        final results = res.data['results'];
        if (results != null && results is List) {
          List<Movie> movies = results
              .whereType<Map<String, dynamic>>()
              .map((json) => Movie.fromJson(json))
              .toList();
          print("Movies: $movies");
          return ApiSuccess(movies);
        } else {
          return ApiSuccess([]);
        }
      } else {
        return ApiFailure(
          ApiExeption(res.statusMessage ?? "Unknown error",
              code: res.statusCode),
        );
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<List<Movie>>> NowPlayingComing() async {
    try {
      Dio dio = DioConfig.getDio();
      const String url = AppConstans.nowPlayingFilms;
      Response res = await dio.get(url);

      if (res.statusCode == 200) {
        final results = res.data['results'];
        if (results != null && results is List) {
          List<Movie> movies = results
              .whereType<Map<String, dynamic>>()
              .map((json) => Movie.fromJson(json))
              .toList();
          return ApiSuccess(movies);
        } else {
          return ApiSuccess([]);
        }
      } else {
        return ApiFailure(
          ApiExeption(res.statusMessage ?? "Unknown error",
              code: res.statusCode),
        );
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<List<Movie>>> recommended() async {
    try {
      Dio dio = DioConfig.getDio();
      const String url = AppConstans.nowPlayingFilms;
      Response res = await dio.get(url);

      if (res.statusCode == 200) {
        final results = res.data['results'];
        if (results != null && results is List) {
          List<Movie> movies = results
              .whereType<Map<String, dynamic>>()
              .map((json) => Movie.fromJson(json))
              .toList();
          print("Movies: $movies");
          return ApiSuccess(movies);
        } else {
          return ApiSuccess([]);
        }
      } else {
        return ApiFailure(
          ApiExeption(res.statusMessage ?? "Unknown error",
              code: res.statusCode),
        );
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<void>> signUp(
      String name, String email, String password) async {
    try {
      Dio dio = DioConfig.getDio();
      const String url = AppConstans.baseUrlUsers;

      final response = await dio.post(url, data: {
        "name": name.trim(),
        "email": email.trim(),
        "password": password,
        "movies": [],
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiSuccess(null);
      } else {
        return ApiFailure(
          ApiExeption(response.statusMessage ?? "Unknown error",
              code: response.statusCode),
        );
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.message ?? e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<Map<String, dynamic>>> login(
      String email, String password) async {
    try {
      Dio dio = DioConfig.getDio();
      const String url = AppConstans.baseUrlUsers;

      final response = await dio.get(url);
      final users = response.data as List;

      final user = users.firstWhere(
        (u) => u['email'] == email.trim() && u['password'] == password.trim(),
        orElse: () => null,
      );

      if (user != null) {
        return ApiSuccess(Map<String, dynamic>.from(user));
      } else {
        return ApiFailure(ApiExeption("Invalid email or password"));
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.message ?? e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<List<Seat>>> fetchSeatsByMovie(String movieId) async {
    try {
      Dio dio = DioConfig.getDio();
      final url = 'https://6912fb9252a60f10c82384c3.mockapi.io/seats';
      Response res = await dio.get(url);

      if (res.statusCode != 200) {
        return ApiFailure(ApiExeption(res.statusMessage ?? 'Unknown error',
            code: res.statusCode));
      }

      List<Seat> seats = [];
      if (res.data != null && res.data is List) {
        seats = (res.data as List)
            .where((json) => json['movieId'] == movieId)
            .map((json) => Seat.fromJson(json))
            .toList();
      }

      // لو الكراسي مش موجودة، نخلقهم ونرجع بالـid الحقيقي
      if (seats.isEmpty) {
        seats = List.generate(
          40,
          (index) => Seat(
            id: '',
            seatNumber: '${index + 1}',
            movieId: movieId,
          ),
        );
        seats = await createSeatsIfNeeded(seats);
      }

      return ApiSuccess(seats);
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  // Create seats if not exists
  Future<List<Seat>> createSeatsIfNeeded(List<Seat> seats) async {
    Dio dio = DioConfig.getDio();
    final url = 'https://6912fb9252a60f10c82384c3.mockapi.io/seats';

    List<Seat> createdSeats = [];

    for (var seat in seats) {
      final res = await dio.post(url, data: seat.toJson());
      if (res.statusCode == 200 || res.statusCode == 201) {
        createdSeats.add(Seat.fromJson(res.data));
      }
    }

    return createdSeats;
  }

  // Book selected seats
  Future<ApiResults<List<Seat>>> bookSeats(List<Seat> seats) async {
    if (seats.isEmpty) return ApiFailure(ApiExeption('No seats selected'));

    try {
      Dio dio = DioConfig.getDio();
      final url = 'https://6912fb9252a60f10c82384c3.mockapi.io/seats';

      await Future.wait(seats
          .map((seat) => dio.put('$url/${seat.id}', data: {'isBooked': true})));

      return await fetchSeatsByMovie(seats.first.movieId);
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<void>> addMovieToUser(
    String userId,
    Map<String, dynamic> movie, // محتاج يكون فيه id و name
    List<Seat> selectedSeats,
  ) async {
    try {
      Dio dio = DioConfig.getDio();
      final userUrl = '${AppConstans.baseUrlUsers}/$userId';

      // 1. نجيب بيانات اليوزر
      final userResp = await dio.get(userUrl);
      if (userResp.statusCode != 200) {
        return ApiFailure(ApiExeption(
          userResp.statusMessage ?? "Failed to fetch user data",
          code: userResp.statusCode,
        ));
      }

      final userData = Map<String, dynamic>.from(userResp.data);
      final List<dynamic> movies = List<dynamic>.from(userData['movies'] ?? []);

      // 2. نجهز أرقام الكراسي الجديدة
      final seatNumbers = selectedSeats.map((s) => s.seatNumber).toList();

      // 3. نشوف إذا الفيلم موجود قبل كده
      final existingIndex = movies.indexWhere((m) => m['id'] == movie['id']);

      if (existingIndex == -1) {
        // الفيلم جديد، نضيفه كامل مع الكراسي
        movies.add({
          "id": movie['id'],
          "name": movie['name'],
          "seats": seatNumbers,
        });
      } else {
        // الفيلم موجود قبل كده، نضيف الكراسي الجديدة من غير تكرار
        final existingSeats =
            List<String>.from(movies[existingIndex]['seats'] ?? []);
        existingSeats.addAll(seatNumbers);
        movies[existingIndex]['seats'] =
            existingSeats.toSet().toList(); // إزالة التكرار
      }

      // 4. تحديث بيانات اليوزر
      final updateResp = await dio.put(userUrl, data: {"movies": movies});

      if (updateResp.statusCode == 200 || updateResp.statusCode == 201) {
        return ApiSuccess<void>(null);
      } else {
        return ApiFailure(ApiExeption(
          updateResp.statusMessage ?? "Failed to update user movies",
          code: updateResp.statusCode,
        ));
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.message ?? e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }

  Future<ApiResults<List<MovieBokked>>> fetchUserMovies(String userId) async {
    try {
      Dio dio = DioConfig.getDio();
      final userUrl = '${AppConstans.baseUrlUsers}/$userId';
      final res = await dio.get(userUrl);

      if (res.statusCode == 200) {
        final userData = Map<String, dynamic>.from(res.data);

        final moviesJson =
            List<Map<String, dynamic>>.from(userData['movies'] ?? []);

        final movies = moviesJson.map((m) => MovieBokked.fromJson(m)).toList();

        return ApiSuccess(movies);
      } else {
        return ApiFailure(ApiExeption(
          res.statusMessage ?? "Failed to fetch user data",
          code: res.statusCode,
        ));
      }
    } on DioException catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    } catch (e) {
      return ApiFailure(ApiExeption(e.toString()));
    }
  }
}
