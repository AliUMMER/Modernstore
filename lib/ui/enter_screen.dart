import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/login/bloc/login_bloc.dart';
import 'package:modern_grocery/repositery/model/login_model.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/home_page.dart';
import 'package:modern_grocery/ui/verify_screen.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({super.key});

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is loginBlocLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationBarWidget()),
          );
          ;
        }
        if (state is loginBlocError) {
          Center(child: Text('Login Error'));
        }
        if (state is loginBlocLoaded) {
          Center(child: CircularProgressIndicator());
        }
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: Color(0XFF0A0909),
        body: Column(
          children: [
            SizedBox(
              height: 75.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 325.w,
                ),
                Container(
                  width: 55,
                  height: 27,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 55,
                          height: 27,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFF5E9B5), Color(0xFF8F8769)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFF0A0808),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 105.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 68.w,
                ),
                Container(
                  width: 295,
                  height: 236,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 12,
                        top: 177,
                        child: Container(
                          width: 249,
                          height: 37,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1.00, 0.00),
                              end: Alignment(-1, 0),
                              colors: [Color(0xFFFFFDD4), Color(0xC1FCF8E8)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 295,
                          height: 236,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Group 3 (1).png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 62.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50.w,
                ),
                Text(
                  'Enter your number',
                  style: TextStyle(
                    color: Color(0xFFF5E9B5),
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50.w,
                ),
                Text(
                  'Mobile Number',
                  style: TextStyle(
                    color: Color(0xFFFCF8E8),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 49.w,
                ),
                Container(
                  width: 83,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0A0808),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Color(0xFFFCF8E8)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: '🇮🇳',
                    items: [
                      DropdownMenuItem(
                        value: '🇮🇳',
                        child: Text('🇮🇳 +91',
                            style: TextStyle(
                              color: Color(0xFFF5E9B5),
                            )),
                      ),
                      // Add more country codes here
                    ],
                    onChanged: (value) {},
                    underline: SizedBox(),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 249,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0A0808),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Color(0xFFFCF8E8)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TextField(
                    controller: phoneController,
                    style: TextStyle(color: Color(0xFFF5E9B5)),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'Enter your mobile number',
                      hintStyle: TextStyle(color: Color(0xFFF5E9B5)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.w,
            ),
            Row(
              children: [
                SizedBox(
                  width: 75.w,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context).add(fetchlogin());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => VerifyScreen()),
                    // );
                  },
                  child: Container(
                    width: 281,
                    height: 54,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 281,
                            height: 54,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF5E9B5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 99,
                          top: 13,
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFF0A0808),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
