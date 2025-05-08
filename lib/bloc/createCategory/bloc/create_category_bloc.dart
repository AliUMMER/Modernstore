import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/api/createCategory_api.dart';
import 'package:modern_grocery/repositery/model/createCategory_model.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  CreatecategoryApi createcategoryApi =
      CreatecategoryApi(apiClient: ApiClient());

  late CreateCategoryModel createCategoryModel;

  CreateCategoryBloc({required CreatecategoryApi createcategoryApi})
      : super(CreateCategoryInitial()) {
    on<FetchCreateCategory>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        createCategoryModel = await createcategoryApi.createCategory(
            categoryName: event.categoryName, imageFile: event.imageFile);
        emit(CreateCategoryLoaded());
      } catch (e) {
        print(e);
        emit(CreateCategoryError(message: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
