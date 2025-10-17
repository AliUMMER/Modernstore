import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Delivery/GetUserDlvAddresses_api.dart';
import 'package:modern_grocery/repositery/model/user/getUserDlvAddresses.dart';

part 'userdeliveryaddress_event.dart';
part 'userdeliveryaddress_state.dart';

class UserdeliveryaddressBloc
    extends Bloc<UserdeliveryaddressEvent, UserdeliveryaddressState> {
  GetUserDeliveryAddressesApi getUserDlvAddressesapi = GetUserDeliveryAddressesApi();
  late GetUserDlvAddresses getUserDlvAddresses;

  UserdeliveryaddressBloc() : super(UserdeliveryaddressInitial()) {
    on<fetchUserdeliveryaddressEvent>((event, emit) async {
      emit(UserdeliveryaddressLoading());

      try {
        getUserDlvAddresses =
            await getUserDlvAddressesapi.getGetUserDlvAddresses();
        emit(UserdeliveryaddressLoaded());
      } catch (e) {
        print('UserDeliveryAddress Error: $e');
        // Check if it's a token error
        if (e.toString().contains('401') || e.toString().contains('Invalid token')) {
          print('Token is invalid or expired for delivery addresses');
        }
        emit(UserdeliveryaddressError());
      }
    });
  }
}
