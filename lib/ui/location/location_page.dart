import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/location/manual_location.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF0A0909),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 240.w,
                      height: 174.h,
                      child: Image.asset(
                        "assets/Group 5.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Text(
                      languageService.getString('select_your_location'),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      languageService.getString('location_description'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0x8CFCF8E8),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.11,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 332.w,
                      height: 61.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5E9B5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: const BorderSide(
                                width: 2, color: Color(0xFFFCF8E8)),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          languageService.getString('allow_location_access'),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF0A0808),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.72,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: 332.w,
                      height: 61.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A0808),
                          side: const BorderSide(
                              color: Color(0xFFFCF8E8), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManualLocation()),
                          );
                        },
                        child: Text(
                          languageService.getString('enter_location_manually'),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFCF8E8),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.72,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
