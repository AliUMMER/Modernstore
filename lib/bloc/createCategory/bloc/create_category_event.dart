part of 'create_category_bloc.dart';

@immutable
sealed class CreateCategoryEvent {}

class FetchCreateCategory extends CreateCategoryEvent {
  final String categoryName;
  final File? imageFile;

  FetchCreateCategory({required this.categoryName, required this.imageFile});
}
