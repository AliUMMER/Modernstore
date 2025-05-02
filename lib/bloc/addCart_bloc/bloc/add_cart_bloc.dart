import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/addCart_api.dart';
import 'package:modern_grocery/repositery/model/addCart_model.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddcartApi addcartApi = AddcartApi();

  late AddCartModel addCartModel;

  AddCartBloc() : super(AddCartInitial()) {
    on<fetchAddCart>((event, emit) async {
      emit(AddCartLoading());
      try {
        addCartModel = await addcartApi.getAddCartModel();
        emit(AddCartLoaded());
      } catch (e) {
        print(e);
      }
      emit(AddCartError());

      // TODO: implement event handler
    });
  }
}
