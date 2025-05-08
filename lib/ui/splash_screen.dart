import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_grocery/ui/onboarding_page.dart';
import 'package:modern_grocery/ui/location_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    // Wait for 2 seconds then navigate
    Timer(
      const Duration(seconds: 2),
      () {
        if (token != null && token.isNotEmpty) {
          // If token exists, user is already logged in
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LocationPage()),
          );
        } else {
          // If no token, show onboarding
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnboardingPage()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E9B5),
      body: Center(
        child: SizedBox(
          height: 250.h,
          width: 250.w,
          child: const Image(
            image: AssetImage('assets/MODERN.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
