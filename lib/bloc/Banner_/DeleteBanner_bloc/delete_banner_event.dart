part of 'delete_banner_bloc.dart';

@immutable
sealed class DeleteBannerEvent {}

class fetchDeleteBannerEvent extends DeleteBannerEvent {
  final String BnnerId;
  fetchDeleteBannerEvent({required this.BnnerId});
}
