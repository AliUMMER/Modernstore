import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/Categories/createCategory_api.dart';
import 'package:modern_grocery/repositery/model/Categories/createCategory_model.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final CreatecategoryApi createcategoryApi;

  CreateCategoryBloc({required this.createcategoryApi})
      : super(CreateCategoryInitial()) {
    on<FetchCreateCategory>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        final result = await createcategoryApi.uploadCategory(
          categoryName: event.categoryName,
          imageFile: event.imageFile!,
        );

        emit(CreateCategoryLoaded(result: result));
      } catch (e) {
        emit(CreateCategoryError(message: e.toString()));
      }
    });
  }
}
