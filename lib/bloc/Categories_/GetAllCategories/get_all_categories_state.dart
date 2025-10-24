part of 'get_all_categories_bloc.dart';

@immutable
sealed class GetAllCategoriesState {}

final class GetAllCategoriesInitial extends GetAllCategoriesState {}

final class GetAllCategoriesLoading extends GetAllCategoriesState {}

final class GetAllCategoriesLoaded extends GetAllCategoriesState {
  // ✅ Use prefixed Category type
  final List<categoryModel.Category> categories;

  GetAllCategoriesLoaded({required this.categories});
}

final class GetAllCategoriesError extends GetAllCategoriesState {}
