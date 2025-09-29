import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
              languageService.getString('about_us'),
              style: GoogleFonts.poppins(
                color: const Color(0xFFF5E9B5),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.r),
                      border: Border.all(color: const Color(0xFFF5E9B5), width: 2),
                    ),
                    child: const Icon(
                      Icons.store,
                      color: Color(0xFFF5E9B5),
                      size: 60,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Text(
                    languageService.getString('welcome_to_modern_store'),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFF5E9B5),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  languageService.getString('our_story'),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  languageService.getString('our_story_text'),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 16.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  languageService.getString('our_mission'),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  languageService.getString('our_mission_text'),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 16.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  languageService.getString('why_choose_us'),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15.h),
                _buildFeatureItem(
                  '🚚',
                  languageService.getString('fast_delivery'),
                  languageService.getString('same_day_delivery'),
                ),
                _buildFeatureItem(
                  '🛡️',
                  languageService.getString('quality_guarantee'),
                  languageService.getString('fresh_products'),
                ),
                _buildFeatureItem(
                  '💰',
                  languageService.getString('best_prices'),
                  languageService.getString('competitive_pricing'),
                ),
                _buildFeatureItem(
                  '📱',
                  languageService.getString('easy_ordering'),
                  languageService.getString('simple_interface'),
                ),
                _buildFeatureItem(
                  '🎯',
                  languageService.getString('customer_support'),
                  languageService.getString('support_247'),
                ),
                SizedBox(height: 30.h),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: const Color(0xFFF5E9B5)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        languageService.getString('contact_information'),
                        style: GoogleFonts.inter(
                          color: const Color(0xFFF5E9B5),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      _buildContactInfo(
                        '📧',
                        languageService.getString('email'),
                        'support@modernstore.com',
                      ),
                      _buildContactInfo(
                        '📞',
                        languageService.getString('phone'),
                        '+1 (234) 567-890',
                      ),
                      _buildContactInfo(
                        '📍',
                        languageService.getString('address'),
                        '123 Modern Street, City, State 12345',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem(String icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color(0xffC4C1B4)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 24.sp)),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFCF8E8).withOpacity(0.8),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 20.sp)),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 14.sp,
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