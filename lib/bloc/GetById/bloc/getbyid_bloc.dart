import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/getbyidproduct_api.dart';
import 'package:modern_grocery/repositery/model/getByIdProduct.dart';

part 'getbyid_event.dart';
part 'getbyid_state.dart';

class GetbyidBloc extends Bloc<GetbyidEvent, GetbyidState> {
  GetbyidproductApi getbyidproductApi = GetbyidproductApi();

  late GetByIdProduct getByIdProduct;

  GetbyidBloc() : super(GetbyidInitial()) {
    on<FetchGetbyid>((event, emit) async {
      emit(GetbyidLoading());
      try {
        getByIdProduct = await getbyidproductApi.getGetByIdProduct();
        emit(GetbyidLoaded());
      } catch (e) {
        print(e);
      }
      emit(GetbyidError());
      // TODO: implement event handler
    });
  }
}
