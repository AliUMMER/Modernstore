part of 'get_category_products_bloc.dart';

@immutable
sealed class GetCategoryProductsEvent {}


class FetchCategoryProducts extends GetCategoryProductsEvent {
  final String categoryId;

  FetchCategoryProducts({required this.categoryId});
}
