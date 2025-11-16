import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Network/api_services.dart';
import 'package:final_project/Network/app_results.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(String name, String email, String password) async {
    emit(SignUpLoading());

    final result = await AppServices.instance.signUp(name, email, password);

    if (result is ApiSuccess<void>) {
      emit(SignUpSuccess());
    } else if (result is ApiFailure<void>) {
      emit(SignUpFailure(result.exception.message));
    }
  }
}
