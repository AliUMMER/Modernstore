part of 'get_all_user_cart_bloc.dart';

@immutable
sealed class GetAllUserCartState {}

final class GetAllUserCartInitial extends GetAllUserCartState {}

final class GetAllUserCartLoading extends GetAllUserCartState {}

final class GetAllUserCartLoaded extends GetAllUserCartState {}

final class GetAllUserCartError extends GetAllUserCartState {}
