import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/bloc/Categories_/createCategory/create_category_bloc.dart';

import 'package:modern_grocery/repositery/api/Categories/GetAllCategories_api.dart';
import 'package:modern_grocery/repositery/model/Banner/getAllBanner%20Model.dart'
    as bannerModel;
import 'package:modern_grocery/repositery/model/Categories/GetAllCategoriesModel.dart'
    as categoryModel;

part 'get_all_categories_event.dart';
part 'get_all_categories_state.dart';

class GetAllCategoriesBloc
    extends Bloc<GetAllCategoriesEvent, GetAllCategoriesState> {
  final GetallcategoriesApi getallcategoriesApi = GetallcategoriesApi();

  GetAllCategoriesBloc() : super(GetAllCategoriesInitial()) {
    on<fetchGetAllCategories>((event, emit) async {
      emit(GetAllCategoriesLoading());
      try {
        final response = await getallcategoriesApi.getGetAllCategories();

        emit(GetAllCategoriesLoaded(categories: response.categories));
      } catch (e) {
        print("Error fetching categories: $e");
        emit(GetAllCategoriesError());
      }
    });
  }
}
