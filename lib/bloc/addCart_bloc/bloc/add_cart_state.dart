part of 'add_cart_bloc.dart';

@immutable
sealed class AddCartState {}

final class AddCartInitial extends AddCartState {}

final class AddCartLoading extends AddCartState {}

final class AddCartLoaded extends AddCartState {}

final class AddCartError extends AddCartState {}
