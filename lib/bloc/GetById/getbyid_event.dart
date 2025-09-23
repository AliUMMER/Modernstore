part of 'getbyid_bloc.dart';

@immutable
sealed class GetbyidEvent {}

class FetchGetbyid extends GetbyidEvent {
  final String id;

  FetchGetbyid(this.id);
}