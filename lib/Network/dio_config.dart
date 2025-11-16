import 'package:dio/dio.dart';
import 'package:final_project/Network/app_constans.dart';

class DioConfig {
  DioConfig._();
  static final Duration _timeOut = Duration(seconds: 30);
  static Dio getDio() {
    Dio dio = Dio()
      ..options.baseUrl = AppConstans.baseUrl
      ..options.responseType = ResponseType.json
      ..options.connectTimeout = _timeOut
      ..options.receiveTimeout = _timeOut
      ..options.headers = {
        'Authorization': 'Bearer ${AppConstans.apiKey}',
        'accept': 'application/json',
      }
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
