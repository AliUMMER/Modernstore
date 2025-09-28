import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourLocation extends StatefulWidget {
  const YourLocation({super.key});

  @override
  State<YourLocation> createState() => _YourLocationState();
}

class _YourLocationState extends State<YourLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 49.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 168.h),
            Text(
              'Enter Your Location',
              style: TextStyle(
                color: const Color(0xFFF5E9B5),
                fontSize: 23.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 23.h),
            SizedBox(
              height: 50.h,
              child: TextField(
                style: TextStyle(color: const Color(0x91FCF8E8)),
                decoration: InputDecoration(
                  hintText: "Search for area...",
                  hintStyle: TextStyle(
                      color: const Color(0x91FCF8E8), fontSize: 12.sp),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFFCF8E8), width: 2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0x91FCF8E8)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                ),
              ),
            ),
            SizedBox(height: 46.h),
            Text(
              'Recent',
              style: TextStyle(
                color: const Color(0xFFF5E9B5),
                fontSize: 23.sp,
             
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFFF5E9B5)),
                SizedBox(width: 16.w),
                Text(
                  'Tirur',
                  style: TextStyle(
                    color: const Color(0xFFF5E9B5),
                    fontSize: 23.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
