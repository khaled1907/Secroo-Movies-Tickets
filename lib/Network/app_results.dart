import 'package:final_project/Network/app_expetion.dart';

sealed class ApiResults<t> {}

class ApiSuccess<t> extends ApiResults<t> {
  final t data;
  ApiSuccess(this.data);
}

class ApiFailure<t> extends ApiResults<t> {
  final ApiExeption exception;

  ApiFailure(this.exception);
}
