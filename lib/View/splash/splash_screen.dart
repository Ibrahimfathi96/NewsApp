import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/pattern.png',
          width: double.infinity,height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(child: Image.asset('assets/images/logo.png'),)
        ],
      ),
    );
  }
}
