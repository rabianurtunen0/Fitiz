import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeStyles {

  final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0XFFB840CD)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0XFF82318A)),
      elevation: MaterialStateProperty.all<double?>(0.0),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(12.5),
          letterSpacing: 1.2,
        ),
      ),
    ),
  );

}
