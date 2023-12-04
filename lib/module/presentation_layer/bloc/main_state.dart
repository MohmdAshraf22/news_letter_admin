part of 'main_bloc.dart';

@immutable
abstract class NewsLetterState {}

class MainInitial extends NewsLetterState {}
// Get News Letter
class GetNewsLetterSuccessState extends NewsLetterState {}
class GetNewsLetterLoadingState extends NewsLetterState {}
// Post News Letter
class PostNewsLetterSuccessState extends NewsLetterState {}
class PostNewsLetterLoadingState extends NewsLetterState {}
// Post News Letter
class EditNewsLetterSuccessState extends NewsLetterState {}
class EditNewsLetterLoadingState extends NewsLetterState {}
// Pick Images
class PickImagesState extends NewsLetterState {}
class DeletePickedImageState extends NewsLetterState {}
class DeleteImageUrlState extends NewsLetterState {}
