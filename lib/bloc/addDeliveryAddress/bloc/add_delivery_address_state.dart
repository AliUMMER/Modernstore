part of 'add_delivery_address_bloc.dart';

@immutable
sealed class AddDeliveryAddressState {}

final class AddDeliveryAddressInitial extends AddDeliveryAddressState {}

final class AddDeliveryAddressLoading extends AddDeliveryAddressState {}

final class AddDeliveryAddressLoaded extends AddDeliveryAddressState {
late AddDeliveryAddress addDeliveryAddress;
  AddDeliveryAddressLoaded({required this.addDeliveryAddress});

}

final class AddDeliveryAddressError extends AddDeliveryAddressState {}
