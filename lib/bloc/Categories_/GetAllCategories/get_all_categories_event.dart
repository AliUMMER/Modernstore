part of 'get_all_categories_bloc.dart';

@immutable
sealed class GetAllCategoriesEvent {}

@override
class fetchGetAllCategories extends GetAllCategoriesEvent {}
