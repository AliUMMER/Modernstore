import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OnboardingPage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5E9B5),
        body: Center(
          child: Container(
            height: 250.h,
            width: 250.w,
            child: Image(
              image: AssetImage('assets/MODERN.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ));
  }
}
