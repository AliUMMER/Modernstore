import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Categories/GetCategoryProducts_api.dart';
import 'package:modern_grocery/repositery/model/GetCategoryProducts_model.dart';

part 'get_category_products_event.dart';
part 'get_category_products_state.dart';

class GetCategoryProductsBloc
    extends Bloc<GetCategoryProductsEvent, GetCategoryProductsState> {
  GetcategoryproductsApi getcategoryproductsApi = GetcategoryproductsApi();

  late GetCategoryProductsModel getCategoryProductsModel =
      GetCategoryProductsModel();

  GetCategoryProductsBloc() : super(GetCategoryProductsInitial()) {
    on<FetchCategoryProducts>((event, emit) async {
      emit(GetCategoryProductsLoading());
      try {
        getCategoryProductsModel = await getcategoryproductsApi
            .getCategoryProductsById(event.categoryId);
        emit(GetCategoryProductsLoaded());
      } catch (e) {
        print('Error: $e');
        emit(GetCategoryProductsError());
      }
    });
  }
}
