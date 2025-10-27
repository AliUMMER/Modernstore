part of 'delete_banner_bloc.dart';

@immutable
sealed class DeleteBannerState {}

final class DeleteBannerInitial extends DeleteBannerState {}

final class DeleteBannerLoading extends DeleteBannerState {}

final class DeleteBannerLoaded extends DeleteBannerState {}

final class DeleteBannerError extends DeleteBannerState {
  final String errorMessage;
  DeleteBannerError({required this.errorMessage});
}
