import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/location_page.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xffFCF8E8)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150.h),
            Text(
              'Enter verification code',
              style: TextStyle(
                color: const Color(0xFFF5E9B5),
                fontSize: 29.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.38,
              ),
            ),
            Text(
              'sent on WhatsApp',
              style: TextStyle(
                color: const Color(0xFFF5E9B5),
                fontSize: 29.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.38,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              'Sent to  +91 55 678 34578',
              style: TextStyle(
                color: const Color(0xB7FCF8E8),
                fontSize: 17.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 56.h),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return Container(
                  width: 58.w,
                  height: 58.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0808),
                    border:
                        Border.all(width: 1, color: const Color(0xFFFCF8E8)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '4', // This should be replaced by user input later
                      style: TextStyle(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 56.h),

            // Resend Code Section
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn’t receive the code?',
                      style: TextStyle(
                        color: const Color(0xD8FCF8E8),
                        fontSize: 13.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.52,
                      ),
                    ),
                    TextSpan(
                      text: '  ',
                      style: TextStyle(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 13.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.52,
                      ),
                    ),
                    TextSpan(
                      text: 'Resend Code',
                      style: TextStyle(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.56,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationPage()),
                    );
                  },
                  child: Container(
                    width: 281,
                    height: 54,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 281,
                            height: 54,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF5E9B5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Color(0xFF0A0808),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
