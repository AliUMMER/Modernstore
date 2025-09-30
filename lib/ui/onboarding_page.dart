import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/localization/app_localizations.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/auth_/enter_screen.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        final lang = languageService.currentLanguage;
        
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Onboarding.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(height: 233.h),
                  Text(
                    AppLocalizations.getString('brand_name', lang),
                    style: GoogleFonts.poppins(
                      color: const Color(0xffF5E9B5),
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 134.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 53.w),
                    child: Text(
                      AppLocalizations.getString('fresh_groceries', lang),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 41.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.41,
                        letterSpacing: -1.64,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    AppLocalizations.getString('real_freshness', lang),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.41,
                      letterSpacing: -0.80,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppLocalizations.getString('for_your_needs', lang),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.41,
                      letterSpacing: -0.80,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 52.h),
                  Center(
                    child: SizedBox(
                      width: 151.w,
                      height: 56.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A0808),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            side: const BorderSide(color: Color(0xFFFCF8E8)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const EnterScreen()));
                        },
                        child: Text(
                          AppLocalizations.getString('get_started', lang),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFCF8E8),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.41,
                            letterSpacing: -0.80,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 82.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.getString('by_joining', lang),
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.41,
                              letterSpacing: -0.60,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.getString('terms_of_service', lang),
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.41,
                              letterSpacing: -0.60,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.getString('and', lang),
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.41,
                              letterSpacing: -0.60,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.getString('privacy_policy_text', lang),
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.41,
                              letterSpacing: -0.60,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
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