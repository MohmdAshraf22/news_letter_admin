import 'package:admin_news_letter/module/domain_layer/entities/image_data.dart';
import 'package:admin_news_letter/module/domain_layer/use_cases/edit_news_use_case.dart';
import 'package:admin_news_letter/module/domain_layer/use_cases/get_news_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/dep_injection.dart';
import '../../data_layer/models/news_model.dart';
import '../../domain_layer/entities/news.dart';
import '../../domain_layer/use_cases/post_news_use_case.dart';
part 'main_event.dart';
part 'main_state.dart';

class NewsLetterBloc extends Bloc<NewsLetterEvent, NewsLetterState> {
  static NewsLetterBloc get(BuildContext context) =>
      BlocProvider.of<NewsLetterBloc>(context);
  List<NewsModel> newsLetter  = [];
  List<ImageData> pickedImages = [];
  List<String> imagesUrl = [];
  NewsLetterBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<NewsLetterEvent>((event, emit) async {
      if (event is GetNewsEvent) {
        emit(GetNewsLetterLoadingState());
        GetNewsUseCase(sl()).get().listen((event) {
          newsLetter = event;
          print(event);
        });
        emit(GetNewsLetterSuccessState());
      }
      else if (event is PickImagesEvent) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          await pickedFile.readAsBytes().then((pickedImage) {
            pickedImages.add(ImageData(
                imageMemory: pickedImage, imageName: pickedFile.name));
            emit(PickImagesState());
          });
        }
      }else if (event is DeletePickedImageEvent) {
        pickedImages.remove(event.imageData);
        emit(DeletePickedImageState());
      }
      else if (event is DeleteImageUrlEvent) {
        imagesUrl.remove(event.imageUrl);
        emit(DeleteImageUrlState());
      }
      else if (event is PostNewsEvent) {
        PostNewsUseCase(sl()).post(newsModel: event.newsModel).listen((event) {
          if(event){
            print("posted");
          }else{
            print("error in posting");
          }
        });
        emit(PostNewsLetterSuccessState());
      }else if (event is EditNewsEvent) {
        EditNewsUseCase(sl()).edit(newsModel: event.newsModel).listen((event) {
          if(event){
            print("Edited");
          }else{
            print("error in editing");
          }
        });
        emit(EditNewsLetterSuccessState());
      }
    });
  }
}
