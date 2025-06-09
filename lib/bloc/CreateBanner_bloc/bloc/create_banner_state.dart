part of 'create_banner_bloc.dart';

@immutable
sealed class CreateBannerState {}

final class CreateBannerInitial extends CreateBannerState {}

final class CreateBannerLoading extends CreateBannerState {}

final class CreateBannerLoaded extends CreateBannerState {}

final class CreateBannerError extends CreateBannerState {}
