part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class GetNewsState extends MainState {}
class PostNewsState extends MainState {}
class PickImagesState extends MainState {}
