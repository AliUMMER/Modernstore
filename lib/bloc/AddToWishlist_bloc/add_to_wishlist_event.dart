part of 'add_to_wishlist_bloc.dart';

@immutable
abstract class AddToWishlistEvent {}

class fetchAddToWishlistEvent extends AddToWishlistEvent {
  final String productId;
  fetchAddToWishlistEvent(this.productId);
}
