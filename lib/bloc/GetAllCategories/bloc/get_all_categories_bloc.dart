import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Categories/GetAllCategories_api.dart';
import 'package:modern_grocery/repositery/api/getallinventory_api.dart';
import 'package:modern_grocery/repositery/model/GetAllCategoriesModel.dart';

part 'get_all_categories_event.dart';
part 'get_all_categories_state.dart';

class GetAllCategoriesBloc
    extends Bloc<GetAllCategoriesEvent, GetAllCategoriesState> {
  GetallcategoriesApi getallcategoriesApi = GetallcategoriesApi();

  late GetAllCategoriesModel getAllCategoriesModel;

  GetAllCategoriesBloc() : super(GetAllCategoriesInitial()) {
    on<fetchGetAllCategories>((event, emit) async {
      // TODO: implement event handler
      emit(GetAllCategoriesLoading());
      try {
        getAllCategoriesModel = await getallcategoriesApi.getGetAllCategories();
        emit(GetAllCategoriesLoaded());
      } catch (e) {
        print(e);
        emit(GetAllCategoriesError());
      }
    });
  }
}
