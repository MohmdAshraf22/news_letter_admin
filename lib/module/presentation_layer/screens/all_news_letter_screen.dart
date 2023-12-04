import 'package:admin_news_letter/core/utils/color_manager.dart';
import 'package:admin_news_letter/core/utils/navigation_manager.dart';
import 'package:admin_news_letter/module/presentation_layer/screens/post_news_letter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/dep_injection.dart';
import '../bloc/main_bloc.dart';
import '../components/components.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsLetterBloc bloc = sl();
    return BlocBuilder<NewsLetterBloc, NewsLetterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("News Letter",
                style: TextStyle(fontSize: 4.sp),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: ColorManager.white,),
              onPressed: (){
            context.push(const PostNewsScreen());
          }),
          body: Padding(
                padding: EdgeInsets.all(8.sp),
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        buildNewsWidget(bloc.newsLetter[index],context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.sp,
                    ),
                    itemCount: bloc.newsLetter.length),
              ),
        );
      },
    );
  }
}