import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/color_manager.dart';

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
