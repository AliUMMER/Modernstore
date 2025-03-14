import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/manual_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0A0909),
      body: Column(
        children: [
          Container(
            width: 430,
            height: 917,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF0A0808)),
            child: Stack(
              children: [
                Positioned(
                  left: 69,
                  top: 196,
                  child: Container(
                    width: 293,
                    height: 174,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 116,
                          child: Container(
                            width: 293,
                            height: 37,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1.00, 0.00),
                                end: Alignment(-1, 0),
                                colors: [Color(0xD3FFFDD4), Color(0xD6FCF8E8)],
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22,
                          top: 0,
                          child: Container(
                            width: 240,
                            height: 174,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Group 5.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 90,
                  top: 424,
                  child: Text(
                    'Select Your Location',
                    style: TextStyle(
                      color: Color(0xFFF5E9B5),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
                Positioned(
                  left: 72,
                  top: 477,
                  child: SizedBox(
                    width: 287,
                    child: SizedBox(
                      width: 287,
                      child: Text(
                        'We need to know your location in order to suggest nearby services',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0x8CFCF8E8),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.11,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 49,
                  top: 554,
                  child: Container(
                    width: 332,
                    height: 61,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 332,
                            height: 61,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF5E9B5),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2, color: Color(0xFFFCF8E8)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Allow Location Access',
                            style: TextStyle(
                              color: Color(0xFF0A0808),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.72,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 49,
                  top: 640,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManualLocation()),
                      );
                    },
                    child: Container(
                      width: 332,
                      height: 61,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 332,
                              height: 61,
                              decoration: ShapeDecoration(
                                color: Color(0xFF0A0808),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2, color: Color(0xFFFCF8E8)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Enter Location Manually',
                              style: TextStyle(
                                color: Color(0xFFFCF8E8),
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.72,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 183,
                  top: 60,
                  child: Container(
                    width: 47.84,
                    height: 48,
                    child: Stack(),
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
