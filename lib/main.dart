import 'package:flutter/material.dart';
import 'package:news/UI/screens/home_page.dart';
import 'package:news/UI/screens/splash_screen.dart';
import 'package:news/UI/style/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightPrimary,
      title: 'News App',
      initialRoute:SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (_)=> SplashScreen(),
        HomePage.routeName : (_)=> HomePage(),
      },
    );
  }
}

