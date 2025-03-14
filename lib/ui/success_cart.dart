import 'package:flutter/material.dart';

class SuccessCart extends StatefulWidget {
  const SuccessCart({super.key});

  @override
  State<SuccessCart> createState() => _SuccessCartState();
}

class _SuccessCartState extends State<SuccessCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0909),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 316,
            ),
            Container(
              height: 184,
              width: 184,
              child: Image(image: AssetImage('assets/s cart.png')),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Successfully added to \nCart !',
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
      ),
    );
  }
}
