part of 'add_to_wishlist_bloc.dart';

@immutable
sealed class AddToWishlistState {}

final class AddToWishlistInitial extends AddToWishlistState {}

final class AddToWishlistLoading extends AddToWishlistState {}

final class AddToWishlistLoaded extends AddToWishlistState {}

final class AddToWishlistError extends AddToWishlistState {}
