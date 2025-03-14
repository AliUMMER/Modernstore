import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0909),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                BackButton(
                  color: Color(0xffffffff),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 130,
                ),
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
            SizedBox(
              height: 25,
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/image 91.png'),
                  ),
                  SizedBox(height: 10),
                  Text('User Name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFCF8E8))),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(height: 30),
            buildSection('General', [
              buildListTile(Icons.person, 'Profile'),
              buildListTile(Icons.location_on, 'My Address'),
              buildListTile(Icons.language, 'Language'),
            ]),
            buildSection('Personal Activity', [
              buildListTile(Icons.account_balance_wallet, 'Wallet Points'),
              buildListTile(Icons.rate_review, 'Customer Review'),
            ]),
            buildSection('Earnings', [
              buildListTile(Icons.group, 'Refer & Earn'),
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
        style: TextStyle(
          color: Color(0xFFFCF8E8),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Color(0xffC4C1B4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      ),
      SizedBox(height: 20),
    ],
  );
}

Widget buildListTile(IconData icon, String text) {
  return ListTile(
    leading: Icon(
      icon,
      color: Color(0xFFFCF8E8),
    ),
    title: Text(
      text,
      style: TextStyle(
        color: Color(0xFFFCF8E8),
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
    onTap: () {},
  );
}
