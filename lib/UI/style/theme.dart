import 'package:flutter/material.dart';

class MyTheme{
  static const Color green = Color(0xff39A552);
  static final ThemeData lightPrimary = ThemeData(
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