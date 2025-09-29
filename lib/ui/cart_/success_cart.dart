import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/localization/app_localizations.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:provider/provider.dart';

class SuccessCart extends StatefulWidget {
  const SuccessCart({super.key});

  @override
  State<SuccessCart> createState() => _SuccessCartState();
}

class _SuccessCartState extends State<SuccessCart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF0A0909),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 316.h),
                Container(
                  height: 184.h,
                  width: 184.w,
                  child: Image.asset('assets/s cart.png'),
                ),
                SizedBox(height: 32.h),
                Text(
                  languageService.getString(
                    'successfully_added_to_cart',
                  ),
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
          ),
        );
      },
    );
  }
}
