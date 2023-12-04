import 'dart:ui' as ui;
import 'package:admin_news_letter/core/utils/navigation_manager.dart';
import 'package:admin_news_letter/module/data_layer/models/news_model.dart';
import 'package:admin_news_letter/module/presentation_layer/bloc/main_bloc.dart';
import 'package:admin_news_letter/module/presentation_layer/screens/details_news_letter_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/dep_injection.dart';
import '../../../core/utils/color_manager.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../domain_layer/entities/image_data.dart';
import 'package:http/http.dart' as http;

import '../../domain_layer/entities/news.dart';

Widget buildNewsWidget(NewsModel news, BuildContext context) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(news.date));
  String timeAgoString = calculateTimeAgo(timeAgo);
  Widget firstRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        timeAgoString,
        style: TextStyle(
            fontSize: 7.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.primary),
      ),
      Text(
        DateFormat('dd-MM-yyyy').format(DateTime.parse(news.date)),
        style: TextStyle(
            fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ],
  );

  List<Widget> imageWidgets = news.imagesUrl
      .take(3)
      .map((image) => Image.network(image, fit: BoxFit.fitHeight))
      .toList();

  Widget imagesRow;

  if (imageWidgets.length == 1) {
    imagesRow = SizedBox(
      height: 60.h,
      width: double.infinity,
      child: imageWidgets[0],
    );
  } else if (imageWidgets.length == 2) {
    imagesRow = Row(
      children: imageWidgets
          .map((image) => Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 45.w),
                  child: image,
                ),
              ))
          .toList(),
    );
  } else {
    imagesRow = Row(
      children: imageWidgets
          .map((image) => Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 30.w),
                  child: image,
                ),
              ))
          .toList(),
    );
  }

  Widget spacedImagesRow = SizedBox(
    height: 60.h,
    width: double.infinity,
    child: imagesRow,
  );
  Widget mainColumn = InkWell(
    onTap: () async {
      context.push(DetailsNewsLetterScreen(newsModel: news));
    },
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          firstRow,
          spacedImagesRow,
          SizedBox(height: 1.h,),
          Text(
            news.head,
            style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.sp),
            child: ReadMoreText(callback: (value) {
              value = false;
            },
                trimCollapsedText: 'read more',
                news.description,
                trimLines: 6,
                style: TextStyle(fontSize: 7.sp, color: Colors.grey),
                trimMode: TrimMode.Line,
                colorClickableText: ColorManager.primary),
          ),
        ],
      ),
    ),
  );

  return mainColumn;
}

// دالة لحساب المدة من التاريخ المعطى إلى الوقت الحالي
String calculateTimeAgo(Duration timeDifference) {
  final int seconds = timeDifference.inSeconds;
  final int minutes = timeDifference.inMinutes;
  final int hours = timeDifference.inHours;
  final int days = timeDifference.inDays;
  final int months = (days / 30).floor();
  final int years = (days / 365).floor();

  if (seconds < 60) {
    return "a minute ago";
  } else if (minutes < 60) {
    return "$minutes minutes ago";
  } else if (hours < 24) {
    return "$hours hours ago";
  } else if (days == 1) {
    return "yesterday";
  } else if (days < 7) {
    return "$days days ago";
  } else if (days > 7 && days < 14) {
    return "last week";
  } else if (months == 1 || days > 14) {
    return "last month";
  } else if (months < 12) {
    return "$months months ago";
  } else if (years == 1) {
    return "last year";
  } else {
    return "$years years ago";
  }
}

Widget defaultFormField(
        {String? label,
        IconData? prefix,
        String? hint,
        IconButton? suffix,
        bool? enabled = true,
        String? validatorText,
        TextInputType? type,
        void Function()? suffixFunction,
        FormFieldValidator? validator,
        bool obscureText = false,
        required TextEditingController controller}) =>
    SizedBox(
      // height: 15.h,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        keyboardType: type,
        enabled: enabled,
        cursorColor: ColorManager.primary,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.sp),
                borderSide: BorderSide(
                  color: ColorManager.black.withOpacity(0.6),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.sp),
                borderSide: BorderSide(
                  color: ColorManager.black.withOpacity(0.6),
                )),
            isDense: false, // Added this
            contentPadding: EdgeInsets.all(5.sp),
            // filled: true,
            fillColor: ColorManager.white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp)),
            prefixIcon: Icon(
              prefix,
            ),
            suffixIcon: suffix,
            labelText: label,
            helperText: hint,
            labelStyle: TextStyle(
              color: ColorManager.black,
            )),
        validator: validator,
      ),
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  double? width = double.infinity,
  double? height,
  Color? textColor,
  Color? buttonColor,
  Color? borderColor,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    Container(
      decoration: BoxDecoration(
        color: buttonColor ?? ColorManager.primary,
        border: Border.all(
          width: 2,
          color: borderColor ?? ColorManager.black.withOpacity(0),
        ),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      width: width,
      height: height ?? 5.h,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 2.h,
            fontWeight: fontWeight,
            color: textColor ?? ColorManager.white,
          ),
        ),
      ),
    );
