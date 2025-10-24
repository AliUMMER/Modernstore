part of 'create_category_bloc.dart';

@immutable
sealed class CreateCategoryState {}

final class CreateCategoryInitial extends CreateCategoryState {}

final class CreateCategoryLoading extends CreateCategoryState {}

final class CreateCategoryLoaded extends CreateCategoryState {
  final  CreateCategoryModel result;
  CreateCategoryLoaded({required this.result});
}

final class CreateCategoryError extends CreateCategoryState {
  final String message;

  CreateCategoryError({required this.message});
}
