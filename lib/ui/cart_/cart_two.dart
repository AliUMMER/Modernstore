import 'package:flutter/material.dart';

class CartTwo extends StatefulWidget {
  const CartTwo({super.key});

  @override
  State<CartTwo> createState() => _CartTwoState();
}

class _CartTwoState extends State<CartTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Column(
        children: [
          SizedBox(
            height: 278,
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image(image: AssetImage('assets/Property 1=Variant5.png')),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Fast, secure, and at your doorstep \nwithin 1 hour!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF5E9B5),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
        ],
      ),
    );
  }
}
