part of 'removetowishlist_bloc.dart';

@immutable
sealed class RemovetowishlistState {}

final class RemovetowishlistInitial extends RemovetowishlistState {}

final class RemovetowishlistLoading extends RemovetowishlistState {}

final class RemovetowishlistLoaded extends RemovetowishlistState {}

final class RemovetowishlistError extends RemovetowishlistState {
  final String message;

  RemovetowishlistError({required this.message});
}
