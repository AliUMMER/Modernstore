import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/ui/settings/Edit_profile.dart';
import 'package:modern_grocery/ui/auth_/enter_screen.dart';
import 'package:modern_grocery/ui/settings/language_page.dart';
import 'package:modern_grocery/ui/settings/help_desk_page.dart';
import 'package:modern_grocery/ui/settings/about_us_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 23.h),
            Row(
              children: [
                SizedBox(width: 10.w),
                const BackButton(color: Color(0xffffffff)),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 150.w),
                Text(
                  'My Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.24,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: const AssetImage('assets/image 91.png'),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'User Name',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFCF8E8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 55.h),
            buildSection('General', [
              buildListTile(Icons.person, 'Profile', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              }),
              buildListTile(Icons.location_on, 'My Address', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Address management coming soon!',
                      style: GoogleFonts.poppins(
                        color: Color(0x80000000),
                      ),
                    ),
                    backgroundColor: Color(0xFFF5E9B5),
                  ),
                );
              }),
              buildListTile(Icons.language, 'Language', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LanguagePage()),
                );
              }),
            ]),
            buildSection('Personal Activity', [
              buildListTile(Icons.account_balance_wallet, 'Wallet Points',
                  onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Wallet feature coming soon!',
                      style: GoogleFonts.poppins(
                        color: Color(0x80000000),
                      ),
                    ),
                    backgroundColor: const Color(0xFFF5E9B5),
                  ),
                );
              }),
              buildListTile(Icons.rate_review, 'Customer Review', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Review feature coming soon!',
                      style: GoogleFonts.poppins(
                        color: Color(0x80000000),
                      ),
                    ),
                    backgroundColor: Color(0xFFF5E9B5),
                  ),
                );
              }),
            ]),
            buildSection('Logout', [
              buildListTile(
                Icons.logout,
                'Logout',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        'Logout',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      content: Text(
                        'Are you sure you want to logout?',
                        style: GoogleFonts.poppins(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Remove token from SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('Token');

                            Navigator.of(context).pop(); // Close the dialog

                            // Navigate to enter screen (clear previous stack)
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EnterScreen()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
            buildSection('Help Desk', [
              buildListTile(Icons.support, 'Help & Support', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpDeskPage()),
                );
              }),
              buildListTile(Icons.info, 'About Us', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()),
                );
              }),
              buildListTile(Icons.description, 'Terms & Conditions', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Terms & Conditions coming soon!',
                      style: GoogleFonts.poppins(
                        color: Color(0x80000000),
                      ),
                    ),
                    backgroundColor: Color(0xFFF5E9B5),
                  ),
                );
              }),
              buildListTile(Icons.privacy_tip, 'Privacy Policy', onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Privacy Policy coming soon!',
                      style: GoogleFonts.poppins(
                        color: Color(0x80000000),
                      ),
                    ),
                    backgroundColor: Color(0xFFF5E9B5),
                  ),
                );
              }),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFCF8E8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: const Color(0xffC4C1B4)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget buildListTile(IconData icon, String text, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFCF8E8), size: 24.sp),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          color: const Color(0xFFFCF8E8),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16.sp,
      ),
      onTap: onTap,
    );
      }
    
  }

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xFFFCF8E8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: const Color(0xffC4C1B4)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

