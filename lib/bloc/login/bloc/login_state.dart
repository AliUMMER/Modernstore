part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class loginBlocLoading extends LoginState {}

class loginBlocLoaded extends LoginState {}

class loginBlocError extends LoginState {}
