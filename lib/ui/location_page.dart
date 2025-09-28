import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/ui/delivery/manual_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Column(
        children: [
          Container(
            width: 430.w,
            height: 917.h,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFF0A0808)),
            child: Stack(
              children: [
                Positioned(
                  left: 69.w,
                  top: 196.h,
                  child: Container(
                    width: 293.w,
                    height: 174.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 116.h,
                          child: Container(
                            width: 293.w,
                            height: 37.h,
                            decoration: const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1.00, 0.00),
                                end: Alignment(-1, 0),
                                colors: [Color(0xD3FFFDD4), Color(0xD6FCF8E8)],
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22.w,
                          top: 0,
                          child: Container(
                            width: 240.w,
                            height: 174.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Group 5.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 90.w,
                  top: 424.h,
                  child: Text(
                    'Select Your Location',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFF5E9B5),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
                Positioned(
                  left: 72.w,
                  top: 477.h,
                  child: SizedBox(
                    width: 287.w,
                    child: Text(
                      'We need to know your location in order to suggest nearby services',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0x8CFCF8E8),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.11,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 49.w,
                  top: 554.h,
                  child: Container(
                    width: 332.w,
                    height: 61.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 332.w,
                            height: 61.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF5E9B5),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xFFFCF8E8)),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Allow Location Access',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0A0808),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.72,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 49.w,
                  top: 640.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManualLocation()),
                      );
                    },
                    child: Container(
                      width: 332.w,
                      height: 61.h,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 332.w,
                              height: 61.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF0A0808),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2, color: Color(0xFFFCF8E8)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Enter Location Manually',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFCF8E8),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.72,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 183.w,
                  top: 60.h,
                  child: Container(
                    width: 47.84.w,
                    height: 48.h,
                    child: const Stack(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}