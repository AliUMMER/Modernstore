part of 'removetowishlist_bloc.dart';

@immutable
sealed class RemovetowishlistEvent {}


final class fetchRemovetowishlistEvent extends RemovetowishlistEvent {
  final String productId;

  fetchRemovetowishlistEvent(this.productId);
}
