import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTwo extends StatefulWidget {
  const CartTwo({super.key});

  @override
  State<CartTwo> createState() => _CartTwoState();
}

class _CartTwoState extends State<CartTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Column(
        children: [
          SizedBox(height: 278.h), // ScreenUtil height
          Center(
            child: Container(
              height: 200.h, // ScreenUtil height
              width: 200.w, // ScreenUtil width
              child: Image.asset('assets/Property 1=Variant5.png'),
            ),
          ),
          SizedBox(height: 50.h), // ScreenUtil height
          Text(
            'Fast, secure, and at your doorstep \nwithin 1 hour!',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter( // ✅ GoogleFonts
              color: const Color(0xFFF5E9B5),
              fontSize: 16.sp, // ScreenUtil font size
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
        ],
      ),
    );
  }
}
