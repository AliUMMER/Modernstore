import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/addDeliveryAddress_api.dart';
import 'package:modern_grocery/repositery/model/addDeliveryAddress.dart';

part 'add_delivery_address_event.dart';
part 'add_delivery_address_state.dart';

class AddDeliveryAddressBloc
    extends Bloc<AddDeliveryAddressEvent, AddDeliveryAddressState> {
  AddDeliveryAddressApi addDeliveryAddressApi = AddDeliveryAddressApi();

  late AddDeliveryAddress addDeliveryAddress;

  AddDeliveryAddressBloc() : super(AddDeliveryAddressInitial()) {
    on<fetchAddDeliveryAddress>((event, emit) async {
      emit(AddDeliveryAddressLoading());
      try {
        addDeliveryAddress =
            await addDeliveryAddressApi.getaddDeliveryAddress();
        emit(AddDeliveryAddressLoaded(addDeliveryAddress: addDeliveryAddress));
      } catch (e) {
        print(e);
        emit(AddDeliveryAddressError());
      }
    });
  }
}
