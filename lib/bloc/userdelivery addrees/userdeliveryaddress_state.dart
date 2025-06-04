part of 'userdeliveryaddress_bloc.dart';

@immutable
sealed class UserdeliveryaddressState {}

final class UserdeliveryaddressInitial extends UserdeliveryaddressState {}

final class UserdeliveryaddressLoading extends UserdeliveryaddressState {}

final class UserdeliveryaddressLoaded extends UserdeliveryaddressState {}

final class UserdeliveryaddressError extends UserdeliveryaddressState {}
