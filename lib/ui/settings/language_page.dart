import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/localization/app_localizations.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'hi', 'name': 'हिन्दी (Hindi)', 'flag': '🇮🇳'},
    {'code': 'de', 'name': 'Deutsch (German)', 'flag': '🇩🇪'},
    {'code': 'ar', 'name': 'العربية (Arabic)', 'flag': '🇸🇦'},
    {'code': 'ml', 'name': 'മലയാളം (Malayalam)', 'flag': '🇮🇳'},
  ];

  Future<void> _changeLanguage(String languageCode, String languageName) async {
    final languageService =
        Provider.of<LanguageService>(context, listen: false);
    await languageService.changeLanguage(languageCode);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${AppLocalizations.getString('language_changed', languageCode)} $languageName'),
        backgroundColor: const Color(0xFFF5E9B5),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0909),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0A0909),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E9B5)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              languageService.getString('language'),
              style: GoogleFonts.poppins(
                color: const Color(0xFFF5E9B5),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageService.getString('select_language'),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      final isSelected =
                          languageService.currentLanguage == language['code'];

                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF5E9B5).withOpacity(0.1)
                              : Colors.black,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFF5E9B5)
                                : const Color(0xffC4C1B4),
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ListTile(
                          leading: Text(
                            language['flag']!,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          title: Text(
                            language['name']!,
                            style: GoogleFonts.poppins(
                              color: isSelected
                                  ? const Color(0xFFF5E9B5)
                                  : const Color(0xFFFCF8E8),
                              fontSize: 16.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: const Color(0xFFF5E9B5),
                                  size: 24.sp,
                                )
                              : null,
                          onTap: () => _changeLanguage(
                              language['code']!, language['name']!),
                        ),
                      );
                    },
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
