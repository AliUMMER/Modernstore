part of 'add_delivery_address_bloc.dart';

@immutable
sealed class AddDeliveryAddressEvent {}

class fetchAddDeliveryAddress extends AddDeliveryAddressEvent {
    final Map<String, dynamic> DeliveryData;

  fetchAddDeliveryAddress({required this.DeliveryData});
}
