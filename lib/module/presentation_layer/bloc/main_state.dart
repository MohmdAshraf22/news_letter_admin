part of 'main_bloc.dart';

@immutable
abstract class NewsLetterState {}

class NewsLetterInitial extends NewsLetterState {}
// Get News Letter
class GetNewsLetterSuccessState extends NewsLetterState {}
class GetNewsLetterLoadingState extends NewsLetterState {}
// Post News Letter
class PostNewsLetterSuccessState extends NewsLetterState {}
class PostNewsLetterLoadingState extends NewsLetterState {}
// Edit News Letter
class EditNewsLetterSuccessState extends NewsLetterState {}
class EditNewsLetterLoadingState extends NewsLetterState {}
// Delete News Letter
class DeleteNewsLetterSuccessState extends NewsLetterState {}
class DeleteNewsLetterLoadingState extends NewsLetterState {}
// Pick Images
class PickImagesState extends NewsLetterState {}
class DeletePickedImageState extends NewsLetterState {}
class DeleteImageUrlState extends NewsLetterState {}
