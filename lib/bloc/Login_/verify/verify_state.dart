part of 'verify_bloc.dart';

@immutable
sealed class VerifyState {}

final class VerifyInitial extends VerifyState {}

final class VerifyLoading extends VerifyState {}

final class VerifySuccess extends VerifyState {
  final Loginmodel login;
  VerifySuccess({required this.login});
}

final class VerifyError extends VerifyState {
  final String message;

  VerifyError({required this.message});
}

final class OTPResent extends VerifyState {}
