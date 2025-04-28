import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/admin_navibar.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/your_location.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  bool isAdmin = true; // Default is user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0909),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 168.h),
              Text(
                'Enter Your Location',
                style: TextStyle(
                  color: Color(0xFFF5E9B5),
                  fontSize: 23,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 23),
              _buildSearchBox(),
              SizedBox(height: 46),
              _buildLocationTile(
                  Icons.my_location, "Use my current location", "Tirur"),
              SizedBox(height: 46),
              _buildAddNewAddress(),
              SizedBox(height: 46),
              _buildSavedAddresses(),
              SizedBox(height: 200),
              _buildConfirmButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFCF8E8), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(color: Color(0x91FCF8E8)),
        decoration: InputDecoration(
          hintText: "Search for area...",
          hintStyle: TextStyle(color: Color(0x91FCF8E8), fontSize: 12),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Color(0x91FCF8E8)),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildLocationTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFCF8E8), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xE8FCF8E8)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Color(0xE8FCF8E8),
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(color: Color(0x91FCF8E8), fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add, color: Color(0xE8FCF8E8)),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => YourLocation()),
            );
          },
          child: Text(
            "Add new address",
            style: TextStyle(color: Color(0xE8FCF8E8), fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedAddresses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Saved addresses",
              style: TextStyle(
                  color: Color(0xE8FCF8E8),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Manage",
              style: TextStyle(color: Color(0xE8FCF8E8), fontSize: 15),
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildLocationTile(
            Icons.location_on, "Tirur", "Tirur ezhur road, 44 villa..."),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (isAdmin == false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminNavibar()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationBarWidget()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF5E9B5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(
          "Confirm address",
          style: TextStyle(
              color: Color(0xFF0A0808),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
