part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}
class GetNewsEvent extends MainEvent {}
class PickImagesEvent extends MainEvent {}
class PostNewsEvent extends MainEvent {
  final NewsModel newsModel;
  PostNewsEvent({required this.newsModel});
}
class DeleteNewsEvent extends MainEvent {
  final String id;
  final String imageUrl;
  DeleteNewsEvent({required this.id,required this.imageUrl});
}
class EditNewsEvent extends MainEvent {
  final NewsModel newsModel;
  EditNewsEvent({required this.newsModel});
}