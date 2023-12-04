import 'package:admin_news_letter/module/data_layer/models/news_model.dart';
import 'package:admin_news_letter/module/presentation_layer/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/dep_injection.dart';
import '../bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController headController = TextEditingController();
    MainBloc bloc = sl()..add(GetNewsEvent());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Add News",
                style: TextStyle(fontSize: 4.sp),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  children: [
                    defaultFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Head is empty";
                          }
                          return null;
                        },
                        controller: headController,
                        hint: "Head"),
                    SizedBox(
                      height: 1.h,
                    ),
                    defaultFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Description is empty";
                          }
                          return null;
                        },
                        controller: descriptionController,
                        hint: "Description"),
                    SizedBox(
                      height: 2.h,
                    ),
                    defaultButton(
                        onPressed: () {
                          bloc.add(PickImagesEvent());
                        },
                        text: "Add Photos"),
                    SizedBox(
                      height: 1.h,
                    ),
                    bloc.pickedImages.isNotEmpty
                        ? Wrap(
                            children: bloc.pickedImages.map((image) {
                              return Card(
                                elevation: 2.sp,
                                child: SizedBox(
                                  height: 50.sp,
                                  width: 50.sp,
                                  child: Image.memory(image.imageMemory),
                                ),
                              );
                            }).toList(),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 1.h,
                    ),
                    defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(PostNewsEvent(
                                newsModel: NewsModel(
                                    imagesUrl: const [],
                                    id: DateTime.now().toString(),
                                    date: DateTime.now().toString(),
                                    description: descriptionController.text,
                                    head: headController.text,
                                    images: bloc.pickedImages)));
                            descriptionController.clear();
                            headController.clear();
                            bloc.pickedImages = [];
                          }
                        },
                        text: "Post"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
