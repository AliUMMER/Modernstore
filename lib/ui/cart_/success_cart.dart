import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessCart extends StatefulWidget {
  const SuccessCart({super.key});

  @override
  State createState() => _SuccessCartState();
}

class _SuccessCartState extends State<SuccessCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 316.h), // ScreenUtil height
            Container(
              height: 184.h, // ScreenUtil height
              width: 184.w,  // ScreenUtil width
              child: Image.asset('assets/s cart.png'),
            ),
            SizedBox(height: 32.h), // ScreenUtil height
            Text(
              'Successfully added to \nCart !',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter( 
                color: const Color(0xFFF5E9B5),
                fontSize: 16.sp, // ScreenUtil font size
                fontWeight: FontWeight.w400,
                letterSpacing: 0.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
