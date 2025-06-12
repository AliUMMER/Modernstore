import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/addCart_api.dart';
import 'package:modern_grocery/repositery/model/addCart_model.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  final AddcartApi addCartApi;

  AddCartBloc({required this.addCartApi}) : super(AddCartInitial()) {
    on<FetchAddCart>((event, emit) async {
      try {
        emit(AddCartLoading());
        final addCartModel = await addCartApi.getAddCartModel(
          event.productId,
          event.quantity,
        );
        emit(AddCartLoaded(addCartModel));
      } catch (e) {
        emit(AddCartError('Failed to add to cart: $e'));
      }
    });
  }
}