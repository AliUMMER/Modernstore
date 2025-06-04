import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/GetUserDlvAddresses_api.dart';
import 'package:modern_grocery/repositery/model/getUserDlvAddresses.dart';

part 'userdeliveryaddress_event.dart';
part 'userdeliveryaddress_state.dart';

class UserdeliveryaddressBloc
    extends Bloc<UserdeliveryaddressEvent, UserdeliveryaddressState> {
  GetUserDlvAddressesapi getUserDlvAddressesapi = GetUserDlvAddressesapi();
  late GetUserDlvAddresses getUserDlvAddresses;

  UserdeliveryaddressBloc() : super(UserdeliveryaddressInitial()) {
    on<fetchUserdeliveryaddressEvent>((event, emit) async {
      emit(UserdeliveryaddressLoading());

      try {
        getUserDlvAddresses =
            await getUserDlvAddressesapi.getGetUserDlvAddresses();
        emit(UserdeliveryaddressLoaded());
      } catch (e) {
        print(e);
        emit(UserdeliveryaddressError());
      }
      // TODO: implement event handler
    });
  }
}
