import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/Login_/login/login_bloc.dart';

import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/auth_/verify_screen.dart';
import 'package:modern_grocery/ui/location/location_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({super.key});

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = '+91';
  String selectedCountryFlag = '🇮🇳';

  void _handleLogin(BuildContext context) {
    final fullPhoneNumber = phoneController.text.trim();
    print('Logging in with $fullPhoneNumber');

    BlocProvider.of<LoginBloc>(context).add(fetchlogin(
      phoneNumber: fullPhoneNumber,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is loginBlocLoaded) {
              final token = state.login.accessToken;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', token);
              print('token saved: $token');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyScreen(
                          phoneNumber:
                              '${selectedCountryCode}${phoneController.text}',
                          phoneNumberForApi: phoneController.text.trim(),
                        )),
              );
            } else if (state is loginBlocError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(languageService.getString(
                    'login_error',
                  )),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is loginBlocLoading) {}
          },
          child: Scaffold(
            backgroundColor: const Color(0XFF0A0909),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * screenWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.05 * screenHeight),

                      // Skip button
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            // Show warning dialog before skipping
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF1C1C1C),
                                  title: Text(
                                    languageService.getString('skip_warning_title'),
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFF5E9B5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    languageService.getString('skip_warning_message'),
                                  
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFCF8E8),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        languageService.getString('cancel'),
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFFF5E9B5),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LocationPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        languageService.getString('continue'),
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 55.w,
                            height: 27.h,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFF5E9B5), Color(0xFF8F8769)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                languageService.getString(
                                  'skip',
                                ),
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF0A0808),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 0.08 * screenHeight),

                      // Logo image with shadow
                      Center(
                        child: SizedBox(
                          width: 0.7 * screenWidth,
                          height: 0.25 * screenHeight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 0.6 * screenWidth,
                                  height: 37.h,
                                  decoration: const ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(1.00, 0.00),
                                      end: Alignment(-1, 0),
                                      colors: [
                                        Color(0xFFFFFDD4),
                                        Color(0xC1FCF8E8)
                                      ],
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Image.asset(
                                "assets/Group 3 (1).png",
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 0.05 * screenHeight),

                      // Title
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.02 * screenWidth),
                        child: Text(
                          languageService.getString(
                            'enter_your_number',
                          ),
                          style: GoogleFonts.poppins(
                            color: Color(0xFFF5E9B5),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 13.h),

                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.02 * screenWidth),
                        child: Text(
                          languageService.getString(
                            'mobile_number',
                          ),
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFCF8E8),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Phone input
                      Row(
                        children: [
                          // Country code dropdown
                          Container(
                            width: 0.2 * screenWidth,
                            height: 54.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF0A0808),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xFFFCF8E8)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: selectedCountryFlag,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Color(0xFFF5E9B5)),
                              isExpanded: true,
                              underline: Container(),
                              dropdownColor: const Color(0xFF0A0808),
                              items: [
                                DropdownMenuItem(
                                  value: '🇮🇳',
                                  child: Center(
                                    child: Text(
                                      '🇮🇳 +91',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFF5E9B5),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: '🇺🇸',
                                  child: Center(
                                    child: Text(
                                      '🇺🇸 +1',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFF5E9B5),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: '🇬🇧',
                                  child: Center(
                                    child: Text(
                                      '🇬🇧 +44',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFF5E9B5),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedCountryFlag = value!;
                                  if (value == '🇮🇳')
                                    selectedCountryCode = '+91';
                                  if (value == '🇺🇸')
                                    selectedCountryCode = '+1';
                                  if (value == '🇬🇧')
                                    selectedCountryCode = '+44';
                                });
                              },
                            ),
                          ),

                          SizedBox(width: 0.02 * screenWidth),

                          // Phone input
                          Expanded(
                            child: Container(
                              height: 54.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF0A0808),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2, color: Color(0xFFFCF8E8)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                controller: phoneController,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFFF5E9B5)),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  hintText: languageService
                                      .getString('enter_mobile_hint'),
                                  hintStyle: GoogleFonts.poppins(
                                      color: const Color(0x99F5E9B5)),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter mobile number";
                                  } else if (!RegExp(r'^[0-9]{10}$')
                                      .hasMatch(value)) {
                                    return "Enter valid 10-digit number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 0.1 * screenHeight),

                      // Continue button
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(languageService.getString(
                                    'please_enter_phone',
                                  )),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            _handleLogin(context);
                          },
                          child: Container(
                            width: 0.7 * screenWidth,
                            height: 54.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF5E9B5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                languageService.getString(
                                  'continue',
                                ),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF0A0808),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
