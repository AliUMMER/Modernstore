part of 'get_all_categories_bloc.dart';

@immutable
sealed class GetAllCategoriesEvent {}

@override
List<Object> get props => [];

class fetchGetAllCategories extends GetAllCategoriesEvent {}
