import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:provider/provider.dart';

class CartTwo extends StatefulWidget {
  const CartTwo({super.key});

  @override
  State<CartTwo> createState() => _CartTwoState();
}

class _CartTwoState extends State<CartTwo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF0A0909),
          body: Column(
            children: [
              SizedBox(height: 278.h),
              Center(
                child: Container(
                  height: 200.h,
                  width: 200.w,
                  child: Image.asset('assets/Property 1=Variant5.png'),
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                languageService.getString('cart_empty_message'),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFFF5E9B5),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}