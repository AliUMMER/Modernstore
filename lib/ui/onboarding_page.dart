import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/localization/app_localizations.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/auth_/enter_screen.dart';
import 'package:provider/provider.dart';

import 'package:modern_grocery/widgets/app_color.dart';
import 'package:modern_grocery/widgets/fontstyle.dart';

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
        return Scaffold(
          //   backgroundColor: appColor.backgroundColor,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onbording.png'),
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
                      AppLocalizations.getString(
                          'brand_name', languageService.currentLanguage),
                      // --- REFACTORED STYLE ---
                      style: fontStyles.heading1.copyWith(
                        color: appColor.textColor,
                        fontSize: 52.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 134.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 53.w),
                      child: Text(
                        AppLocalizations.getString(
                            'fresh_groceries', languageService.currentLanguage),
                        // --- REFACTORED STYLE ---
                        style: fontStyles.heading1.copyWith(
                          color: appColor.textColor2,
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
                      AppLocalizations.getString(
                          'real_freshness', languageService.currentLanguage),
                      // --- REFACTORED STYLE ---
                      style: fontStyles.heading2.copyWith(
                        color: appColor.textColor2,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.41,
                        letterSpacing: -0.80,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      AppLocalizations.getString(
                          'for_your_needs', languageService.currentLanguage),
                      // --- REFACTORED STYLE ---
                      style: fontStyles.heading2.copyWith(
                        color: appColor.textColor2,
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
                            backgroundColor: appColor.textColor3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side:
                                  const BorderSide(color: appColor.textColor2),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const EnterScreen()));
                          },
                          child: Text(
                            AppLocalizations.getString(
                                'get_started', languageService.currentLanguage),
                            // --- REFACTORED STYLE ---
                            style: fontStyles.primaryTextStyle.copyWith(
                              color: appColor.textColor2,
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
                              text: AppLocalizations.getString('by_joining',
                                  languageService.currentLanguage),
                              // --- REFACTORED STYLE ---
                              style: fontStyles.caption.copyWith(
                                color: appColor.textColor2,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.41,
                                letterSpacing: -0.60,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.getString(
                                  'terms_of_service',
                                  languageService.currentLanguage),
                              // --- REFACTORED STYLE ---
                              style: fontStyles.caption.copyWith(
                                color: appColor.textColor2,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.41,
                                letterSpacing: -0.60,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.getString(
                                  'and', languageService.currentLanguage),
                              style: fontStyles.caption.copyWith(
                                color: appColor.textColor2,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.41,
                                letterSpacing: -0.60,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.getString(
                                  'privacy_policy_text',
                                  languageService.currentLanguage),
                              style: fontStyles.caption.copyWith(
                                color: appColor.textColor2,
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
