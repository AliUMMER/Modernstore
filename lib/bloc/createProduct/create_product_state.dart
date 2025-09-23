part of 'create_product_bloc.dart';

@immutable
sealed class CreateProductState {}

final class CreateProductInitial extends CreateProductState {}

final class CreateProductILoading extends CreateProductState {}

final class CreateProductLoaded extends CreateProductState {
  final CreateProductModel createProduct;

  CreateProductLoaded({required this.createProduct});
}

final class CreateProductError extends CreateProductState {
  final String message;
  CreateProductError({required this.message});
}
