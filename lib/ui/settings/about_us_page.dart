import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'About Us',
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
            Text(
              'Welcome to Modern Store',
              style: GoogleFonts.poppins(
                color: const Color(0xFFF5E9B5),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Text(
              'Our Story',
              style: GoogleFonts.inter(
                color: const Color(0xFFF5E9B5),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Modern Store was founded with a vision to revolutionize the way people shop for groceries and daily essentials. We believe in providing fresh, quality products delivered right to your doorstep with convenience and reliability.',
              style: GoogleFonts.inter(
                color: const Color(0xFFFCF8E8),
                fontSize: 16.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Our Mission',
              style: GoogleFonts.inter(
                color: const Color(0xFFF5E9B5),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'To make grocery shopping effortless, affordable, and accessible to everyone while maintaining the highest standards of quality and customer service.',
              style: GoogleFonts.inter(
                color: const Color(0xFFFCF8E8),
                fontSize: 16.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Why Choose Us?',
              style: GoogleFonts.inter(
                color: const Color(0xFFF5E9B5),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15.h),
            _buildFeatureItem(
                '🚚', 'Fast Delivery', 'Same-day delivery available'),
            _buildFeatureItem(
                '🛡️', 'Quality Guarantee', 'Fresh products every time'),
            _buildFeatureItem(
                '💰', 'Best Prices', 'Competitive pricing on all items'),
            _buildFeatureItem(
                '📱', 'Easy Ordering', 'Simple and intuitive app interface'),
            _buildFeatureItem(
                '🎯', 'Customer Support', '24/7 support for all your needs'),
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
                    'Contact Information',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFF5E9B5),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  _buildContactInfo('📧', 'Email', 'support@modernstore.com'),
                  _buildContactInfo('📞', 'Phone', '+1 (234) 567-890'),
                  _buildContactInfo(
                      '📍', 'Address', '123 Modern Street, City, State 12345'),
                ],
              ),
            ),
          ],
        ),
      ),
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
