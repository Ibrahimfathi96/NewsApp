import 'package:flutter/material.dart';

class MyTheme{
  static const Color green = Color(0xff39A552);
  static final ThemeData lightPrimary = ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)),
          )),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.white,
      ),
        headlineMedium: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 20,
        color: Colors.white,
      )
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: green ,
      centerTitle: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28)
        )
      )
    )
  );
}