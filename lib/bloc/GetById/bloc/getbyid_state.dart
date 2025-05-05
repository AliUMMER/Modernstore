part of 'getbyid_bloc.dart';

@immutable
sealed class GetbyidState {}

final class GetbyidInitial extends GetbyidState {}

final class GetbyidLoading extends GetbyidState {}

final class GetbyidLoaded extends GetbyidState {}

final class GetbyidError extends GetbyidState {}
