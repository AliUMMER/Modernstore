part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class loginBlocLoading extends LoginState {}

final class OTPSentSuccess extends LoginState {}

final class loginBlocLoaded extends LoginState {
  final Loginmodel login;
  loginBlocLoaded({required this.login});
}

class loginBlocError extends LoginState {}
