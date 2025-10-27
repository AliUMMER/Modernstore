import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/ui/auth_/enter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({
    super.key,
  });

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String _adminNumber = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => EnterScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> _loadAdminData() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _adminNumber = prefs.getString('number') ?? '';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      appBar: AppBar(
        title: Text(
          'Admin Profile',
          style: GoogleFonts.poppins(color: const Color(0xFFFCF8E8)),
        ),
        backgroundColor: const Color(0XFF0A0909),
        foregroundColor: const Color(0xFFFCF8E8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
     
            Icon(
              Icons.admin_panel_settings,
              size: 80.w,
              color: const Color(0xFFF5E9B5),
            ),
            SizedBox(height: 12.h),
            Text(
              'Administrator',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _adminNumber,
              style: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 40.h),

            // --- Menu Options ---

            // Placeholder for other settings
            _buildProfileTile(
              context: context,
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // TODO: Navigate to a settings page
              },
            ),
            SizedBox(height: 16.h),

            // --- Log Out Button ---
            _buildProfileTile(
              context: context,
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                // Show confirmation dialog before logging out
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    backgroundColor: const Color(0xff292727), // Dark card color
                    title: Text(
                      'Log Out',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    content: Text(
                      'Are you sure you want to log out?',
                      style: GoogleFonts.poppins(color: Colors.grey[300]),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(color: Colors.grey[400]),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFF5E9B5)), // Accent
                        ),
                        onPressed: () {
                          _logout(context); // Call the logout function
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build themed list tiles
  Widget _buildProfileTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff292727), // Dark grey card color from your theme
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFFF5E9B5), // Accent color
                  size: 24.sp,
                ),
                SizedBox(width: 20.w),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
