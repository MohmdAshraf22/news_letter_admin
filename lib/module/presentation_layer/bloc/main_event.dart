part of 'main_bloc.dart';

@immutable
abstract class NewsLetterEvent {}
class GetNewsEvent extends NewsLetterEvent {}
class PickImagesEvent extends NewsLetterEvent {}
class DeletePickedImageEvent extends NewsLetterEvent {
  final ImageData imageData;
  DeletePickedImageEvent({required this.imageData});
}class DeleteImageUrlEvent extends NewsLetterEvent {
  final String imageUrl;
  DeleteImageUrlEvent({required this.imageUrl});
}
class PostNewsEvent extends NewsLetterEvent {
  final NewsModel newsModel;
  PostNewsEvent({required this.newsModel});
}
class DeleteNewsEvent extends NewsLetterEvent {
  final String id;
  final String imageUrl;
  DeleteNewsEvent({required this.id,required this.imageUrl});
}
class EditNewsEvent extends NewsLetterEvent {
  final NewsModel newsModel;
  EditNewsEvent({required this.newsModel});
}