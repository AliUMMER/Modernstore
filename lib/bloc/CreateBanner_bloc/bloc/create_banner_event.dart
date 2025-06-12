part of 'create_banner_bloc.dart';

@immutable
abstract class CreateBannerEvent {}

class FetchCreateBannerEvent extends CreateBannerEvent {
  final String title;
  final String category;
  final String type;
  final String categoryId;
  final String link;
  final String imagePath;
  final void Function(int sent, int total)? onSendProgress;

  FetchCreateBannerEvent({
    required this.title,
    required this.category,
    required this.type,
    required this.categoryId,
    required this.link,
    required this.imagePath,
    this.onSendProgress,
  });
}
