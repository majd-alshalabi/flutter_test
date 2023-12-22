part of 'siginin_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class LoginError extends SignInState {
  final String error;

  LoginError(this.error);
}

class LoginLoading extends SignInState {}

class LoginLoaded extends SignInState {
  final LoginResponseModel model;

  LoginLoaded({required this.model});
}
