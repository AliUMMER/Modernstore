part of 'get_to_wishlist_bloc.dart';

@immutable
sealed class GetToWishlistState {}

final class GetToWishlistInitial extends GetToWishlistState {}

final class GetToWishlistLoading extends GetToWishlistState {}

final class GetToWishlistLoaded extends GetToWishlistState {}

final class GetToWishlistError extends GetToWishlistState {}
