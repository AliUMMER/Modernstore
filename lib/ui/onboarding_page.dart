import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/enter_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 233.h),
            Text(
              'Modern Group',
              style: TextStyle(
                color: Color(0xffF5E9B5),
                fontSize: 52,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 134.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 53.w),
              child: Text(
                'Fresh Groceries Just For You',
                style: TextStyle(
                  color: Color(0xFFFCF8E8),
                  fontSize: 41,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.41,
                  letterSpacing: -1.64,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'All Time Have Real Freshness',
              style: TextStyle(
                color: Color(0xFFFCF8E8),
                fontSize: 35,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.41,
                letterSpacing: -0.80,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'And Are Intended For Your Needs',
              style: TextStyle(
                color: Color(0xFFFCF8E8),
                fontSize: 35,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.41,
                letterSpacing: -0.80,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 52.h),
            Center(
              child: SizedBox(
                width: 151,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A0808),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFFFCF8E8)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => EnterScreen()));
                  },
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Color(0xFFFCF8E8),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.41,
                      letterSpacing: -0.80,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 82.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'By Joining You Agree To Our ',
                      style: TextStyle(
                        color: Color(0xFFFCF8E8),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.41,
                        letterSpacing: -0.60,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms Of Service ',
                      style: TextStyle(
                        color: Color(0xFFFCF8E8),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        letterSpacing: -0.60,
                      ),
                    ),
                    TextSpan(
                      text: 'And ',
                      style: TextStyle(
                        color: Color(0xFFFCF8E8),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.41,
                        letterSpacing: -0.60,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy ',
                      style: TextStyle(
                        color: Color(0xFFFCF8E8),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.41,
                        letterSpacing: -0.60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
