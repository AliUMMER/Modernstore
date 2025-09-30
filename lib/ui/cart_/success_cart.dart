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

class _SuccessCartState extends State<SuccessCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;
  bool _showSecondImage = false;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );

    // Blink 2 times then show second image
    _startBlinkAnimation();
  }

  void _startBlinkAnimation() async {
    // Blink twice (forward + reverse = 1 blink)
    await _blinkController.forward();
    await _blinkController.reverse();
    await _blinkController.forward();
    await _blinkController.reverse();

    // After blinking, show second image
    setState(() {
      _showSecondImage = true;
    });
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

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
                // Show first image with blinking or second image after blinking
                if (!_showSecondImage)
                  // First image with circular shadow and blink animation
                  AnimatedBuilder(
                    animation: _blinkAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _blinkAnimation.value,
                        child: Container(
                          height: 184.h,
                          width: 184.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF5E9B5).withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/s cart.png',
                              height: 100.h,
                              width: 100.w,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                else
                  // Second image replaces first image in the same place
                  Container(
                    height: 184.h,
                    width: 184.w,
                    child: Image.asset('assets/Property 1=Variant7.svg'),
                  ),
                SizedBox(height: 32.h),
                Text(
                  languageService.getString(
                    'successfully added to cart',
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
