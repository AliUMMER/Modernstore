import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/fav/removeWishlist.dart';

part 'removetowishlist_event.dart';
part 'removetowishlist_state.dart';

class RemovetowishlistBloc
    extends Bloc<RemovetowishlistEvent, RemovetowishlistState> {
  RemovewishlistApi removewishlistApi = RemovewishlistApi();

  RemovetowishlistBloc() : super(RemovetowishlistInitial()) {
    on<fetchRemovetowishlistEvent>((event, emit) {
      emit(RemovetowishlistLoading());
      try {
        removewishlistApi.removewish(event.productId);
        emit(RemovetowishlistLoaded());
      } catch (e) {
        print(e);
        emit(RemovetowishlistError(message: e.toString()));
      }
    });
  }
}
