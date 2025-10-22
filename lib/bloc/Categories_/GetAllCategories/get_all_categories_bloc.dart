import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Categories/GetAllCategories_api.dart';
import 'package:modern_grocery/repositery/model/Banner/getAllBanner%20Model.dart';
import 'package:modern_grocery/repositery/model/Categories/GetAllCategoriesModel.dart';



part 'get_all_categories_event.dart';
part 'get_all_categories_state.dart';

class GetAllCategoriesBloc
    extends Bloc<GetAllCategoriesEvent, GetAllCategoriesState> {
  final GetallcategoriesApi getallcategoriesApi = GetallcategoriesApi();
  List<GetAllCategoriesModel> categories = [];
//  late GetAllCategoriesModel getAllCategoriesModel;

  GetAllCategoriesBloc() : super(GetAllCategoriesInitial()) {
    on<fetchGetAllCategories>((event, emit) async {
      emit(GetAllCategoriesLoading());
      try {
      
            await getallcategoriesApi.getGetAllCategories();

        emit(GetAllCategoriesLoaded(
            categories: categories));
      } catch (e) {
        print(e);
        emit(GetAllCategoriesError());
      }
    });
  }
}
