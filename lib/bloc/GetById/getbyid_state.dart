part of 'getbyid_bloc.dart';

@immutable
sealed class GetbyidState {@override
  List<Object?> get props => [];}
class GetbyidInitial extends GetbyidState {}

class GetbyidLoading extends GetbyidState {}

class GetbyidLoaded extends GetbyidState {
  final GetByIdProduct getByIdProduct;

  GetbyidLoaded({required this.getByIdProduct});

  @override
  List<Object?> get props => [getByIdProduct];
}

class GetbyidError extends GetbyidState {
  final String message;

  GetbyidError({required this.message});

  @override
  List<Object?> get props => [message];
}