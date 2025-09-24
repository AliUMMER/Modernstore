import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/product/getbyidproduct_api.dart';
import 'package:modern_grocery/repositery/model/getByIdProduct.dart';

part 'getbyid_event.dart';
part 'getbyid_state.dart';

class GetbyidBloc extends Bloc<GetbyidEvent, GetbyidState> {
  final GetbyidproductApi getbyidproductApi;

  GetbyidBloc({required this.getbyidproductApi}) : super(GetbyidInitial()) {
    on<FetchGetbyid>((event, emit) async {
      emit(GetbyidLoading());
      try {
        if (event.id.isEmpty) {
          throw Exception('Product ID is empty');
        }
        final getByIdProduct =
            await getbyidproductApi.getGetByIdProduct(event.id);
        print('Fetched product: ${getByIdProduct.data?.name}');
        emit(GetbyidLoaded(getByIdProduct: getByIdProduct));
      } catch (e) {
        print('Error fetching product: $e');
        emit(GetbyidError(message: e.toString()));
      }
    });
  }
}
