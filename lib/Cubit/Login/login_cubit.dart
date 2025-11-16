import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Network/api_services.dart';
import 'package:final_project/Network/app_results.dart';
import 'package:final_project/sharedPrefrences/shared_prefrences.dart';

abstract class LoginState extends Equatable {
  LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic> user;
  LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final result = await AppServices.instance.login(email, password);

    if (result is ApiSuccess<Map<String, dynamic>>) {
      final user = result.data;
      await SharedPreferencesClass.setUserDetails(user);
      emit(LoginSuccess(user));
    } else if (result is ApiFailure<Map<String, dynamic>>) {
      emit(LoginFailure(result.exception.message));
    }
  }
}
