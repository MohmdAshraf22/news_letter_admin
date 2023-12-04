import 'package:admin_news_letter/module/domain_layer/entities/image_data.dart';
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

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(BuildContext context) =>
      BlocProvider.of<MainBloc>(context);
  List<News> news = [];
  List<ImageData> pickedImages = [];
  MainBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<MainEvent>((event, emit) async {
      if (event is GetNewsEvent) {
        GetNewsUseCase(sl()).get().listen((event) {
          news = event;
          print(news);
        });
        emit(GetNewsState());
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
      }
      else if (event is PostNewsEvent) {
        PostNewsUseCase(sl()).post(newsModel: event.newsModel).listen((event) {
          if(event){
            print("posted");
          }else{
            print("error in posting");
          }
        });
        emit(PostNewsState());
      }
    });
  }
}
