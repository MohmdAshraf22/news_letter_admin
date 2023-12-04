
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'font_manager.dart';

TextStyle _getTextStyle (double fontSize, FontWeight fontWeight , Color color)
{
  return TextStyle(fontSize:  fontSize , color:  color , fontWeight: fontWeight,);
}
TextStyle getRegularStyle ({double fontSize =
    FontSizeManager.s12,  required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.regular, color );
}

TextStyle getMediumStyle ({double fontSize =
    FontSizeManager.s12,  required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.medium, color );
}


TextStyle getLightStyle ({double fontSize =
    FontSizeManager.s12,  required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.light, color );
}


TextStyle getSemiBoldStyle ({double fontSize =
    FontSizeManager.s12,  required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color );
}


TextStyle getBoldStyle ({double fontSize =
    FontSizeManager.s12,  required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.bold ,
      color );
}