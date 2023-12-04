import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      fontFamily: 'Abg',
      hintColor: ColorManager.primary,
      hoverColor: ColorManager.primary.withOpacity(.10),
      //colorScheme: ColorScheme(brightness: Brightness.light, primary: P, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),
      //primarySwatch: MaterialColor(10, ),
      drawerTheme: DrawerThemeData(
        width: 70.w,
      ),
      textButtonTheme: const TextButtonThemeData(),
      scaffoldBackgroundColor: ColorManager.white,
      primaryColor: ColorManager.primary,
      //   primaryColorLight: ColorManager.primaryLight,
      disabledColor: ColorManager.grey1,
      appBarTheme: AppBarTheme(
        color: ColorManager.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 1.2.sp,
        titleTextStyle: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSizeManager.s16.sp,
        ),
        iconTheme: IconThemeData(color: ColorManager.black, size: 25.sp),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primary,
      ),
      buttonTheme: ButtonThemeData(
        //  disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        height: SizeManager.s50.sp,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorManager.primary,
          background: ColorManager.primary,
        ),

        shape: const StadiumBorder(),
        //textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: SizeManager.s4.sp,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      unselectedWidgetColor: ColorManager.grey1,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManager.white, fontSize: FontSizeManager.s16.sp), backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeManager.s15.sp)))),
      inputDecorationTheme: InputDecorationTheme(
          // content padding
          contentPadding: EdgeInsets.all(PaddingManager.p10.sp),
          // hint style
          hintStyle: getRegularStyle(
              color: ColorManager.grey1, fontSize: FontSizeManager.s14.sp),
          labelStyle: getMediumStyle(
              color: ColorManager.grey1, fontSize: FontSizeManager.s14.sp),
          errorStyle: getRegularStyle(color: Colors.red),

          // enabled border style
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.grey2, width: SizeManager.s1_5.sp),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeManager.s40.sp))),

          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primary, width: SizeManager.s1_5.sp),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeManager.s40.sp))),

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.red, width: SizeManager.s1_5.sp),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeManager.s40.sp))),
          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primary, width: SizeManager.s1_5.sp),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeManager.s40.sp)))),
      iconTheme: IconThemeData(color: ColorManager.primary)
      // label style
      );
}
