import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Delivery/addDeliveryAddress_api.dart';


part 'add_delivery_address_event.dart';
part 'add_delivery_address_state.dart';

class AddDeliveryAddressBloc
    extends Bloc<AddDeliveryAddressEvent, AddDeliveryAddressState> {
  AddDeliveryAddressApi addDeliveryAddressApi = AddDeliveryAddressApi();

  AddDeliveryAddressBloc() : super(AddDeliveryAddressInitial()) {
    on<fetchAddDeliveryAddress>((event, emit) async {
      emit(AddDeliveryAddressLoading());
      try {
        await addDeliveryAddressApi.getaddDeliveryAddress(event.DeliveryData);
        emit(AddDeliveryAddressLoaded(DeliveryData: {}));
      } catch (e) {
        print(e);
        emit(AddDeliveryAddressError());
      }
    });
  }
}
