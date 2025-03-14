import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/cart_two.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0909),
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 40.w,
              ),
              BackButton(
                color: Color(0xffFFFFFF),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
              child: Text(
            'Select Delivery Address',
            style: TextStyle(
              color: Color(0xFFFCF8E8),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.18,
            ),
          )),
          SizedBox(height: 69),
          Container(
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
          ),
          SizedBox(
            height: 56,
          ),
          Row(
            children: [
              SizedBox(
                width: 34,
              ),
              Icon(Icons.my_location, color: Color(0xE8FCF8E8)),
              SizedBox(
                width: 10,
              ),
              Text(
                'Use current location',
                style: TextStyle(
                  color: Color(0xFFFCF8E8),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 56,
          ),
          Row(
            children: [
              SizedBox(
                width: 34,
              ),
              Icon(Icons.add, color: Color(0xE8FCF8E8)),
              SizedBox(
                width: 10,
              ),
              Text(
                'Add address',
                style: TextStyle(
                  color: Color(0xFFFCF8E8),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF5E9B5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartTwo()),
                );
              },
              child: const Center(
                child: Text('Continue', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
