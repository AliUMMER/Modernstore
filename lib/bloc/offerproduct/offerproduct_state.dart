part of 'offerproduct_bloc.dart';

@immutable
sealed class OfferproductState {}

final class OfferproductInitial extends OfferproductState {}

final class OfferproductLoading extends OfferproductState {}

final class OfferproductLoaded extends OfferproductState {}

final class OfferproductError extends OfferproductState {}
