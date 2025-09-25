import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/auth_/enter_screen.dart';
import 'package:modern_grocery/ui/user_profile.dart';
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 23),
            const Row(
              children: [
                SizedBox(width: 10),
                BackButton(color: Color(0xffffffff)),
              ],
            ),
            const Row(
              children: [
                SizedBox(width: 150),
                Text(
                  'My Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFCF8E8),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/image 91.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFCF8E8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 55),
            buildSection('General', [
              buildListTile(Icons.person, 'Profile', onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              }),
              buildListTile(Icons.location_on, 'My Address'),
              buildListTile(Icons.language, 'Language'),
            ]),
            buildSection('Personal Activity', [
              buildListTile(Icons.account_balance_wallet, 'Wallet Points'),
              buildListTile(Icons.rate_review, 'Customer Review'),
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
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
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
                                  builder: (context) => EnterScreen()),
                              (route) => false,
                            );
                          },
                          child: const Text('Logout',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
            buildSection('Help Desk', [
              buildListTile(Icons.support, 'Help & Support'),
              buildListTile(Icons.info, 'About Us'),
              buildListTile(Icons.description, 'Terms & Conditions'),
              buildListTile(Icons.privacy_tip, 'Privacy Policy'),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget buildSection(String title, List<Widget> children) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFCF8E8),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: const Color(0xffC4C1B4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget buildListTile(IconData icon, String text, {VoidCallback? onTap}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFFFCF8E8)),
    title: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFCF8E8),
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing:
        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
    onTap: onTap,
  );
}
