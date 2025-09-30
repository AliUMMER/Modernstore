import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/widgets/app_color.dart';
import 'package:provider/provider.dart';

class DeliverySuccess extends StatefulWidget {
  const DeliverySuccess({super.key});

  @override
  State<DeliverySuccess> createState() => _DeliverySuccessState();
}

class _DeliverySuccessState extends State<DeliverySuccess>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _animation = Tween<double>(
        begin: -200.0,
        end: MediaQuery.of(context).size.width + 200.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
                SizedBox(
                  height: 90.h,
                  width: double.infinity,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          Positioned(
                            left: _animation.value,
                            child: Container(
                              height: 90.h,
                              width: 90.w,
                              child: Image.asset('assets/Icon/In Transit.svg'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 150.h),
                Text(
                  languageService.getString(
                    'Fast, secure, and at your doorstep\nwithin 1 hour!',
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppConstants.textColor,
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
