part of 'get_category_products_bloc.dart';

@immutable
sealed class GetCategoryProductsState {}

final class GetCategoryProductsInitial extends GetCategoryProductsState {}

final class GetCategoryProductsLoading extends GetCategoryProductsState {}

final class GetCategoryProductsLoaded extends GetCategoryProductsState {}

final class GetCategoryProductsError extends GetCategoryProductsState {}
