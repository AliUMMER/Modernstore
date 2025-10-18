import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/Login_/verify/verify_bloc.dart';
import 'package:modern_grocery/bloc/Login_/verify/verify_event.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/location/location_page.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber; // Display format: +91 1234567890
  final String phoneNumberForApi; // API format: 1234567890

  const VerifyScreen({
    super.key,
    required this.phoneNumber,
    required this.phoneNumberForApi,
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Auto focus on first field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String getOTP() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void _handleVerify(BuildContext context) {
    final otp = getOTP();

    // Validate OTP length
    if (otp.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LanguageService>(context, listen: false)
                  .getString('please_enter_complete_otp') ??
              'Please enter complete 5-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Trigger OTP verification
    BlocProvider.of<VerifyBloc>(context).add(
      fetchVerifyOTPEvent(
        phoneNumber: widget.phoneNumberForApi,
        otp: otp,
      ),
    );
  }

  void _handleResendOTP(BuildContext context) {
    // Clear existing OTP fields
    for (var controller in otpControllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();

    // Trigger resend OTP
    BlocProvider.of<VerifyBloc>(context).add(
      ResendOTPRequested(phoneNumber: widget.phoneNumberForApi),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return BlocListener<VerifyBloc, VerifyState>(
          listener: (context, state) {
            // Dismiss any existing snackbars
            ScaffoldMessenger.of(context).clearSnackBars();

            if (state is VerifySuccess) {
              setState(() {
                isLoading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      languageService.getString('verification_success') ??
                          'Verification Successful!'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );

              // Navigate to location page after brief delay
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationPage()),
                );
              });
            } else if (state is VerifyError) {
              setState(() {
                isLoading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );

              // Clear OTP fields on error
              for (var controller in otpControllers) {
                controller.clear();
              }
              focusNodes[0].requestFocus();
            } else if (state is OTPResent) {
              setState(() {
                isLoading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(languageService.getString('otp_resent') ??
                      'OTP has been resent successfully'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is VerifyLoading) {
              setState(() {
                isLoading = true;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(languageService.getString('processing') ??
                          'Processing...'),
                    ],
                  ),
                  duration: const Duration(seconds: 30),
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0XFF0A0909),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const BackButton(color: Color(0xffFCF8E8)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150.h),

                    // Title
                    Text(
                      languageService.getString('enter_verification_code') ??
                          'Enter verification code',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 29.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),

                    Text(
                      languageService.getString('sent_on_whatsapp') ??
                          'sent on WhatsApp',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 29.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // Phone number display
                    Text(
                      '${languageService.getString('sent_to') ?? 'Sent to'} ${widget.phoneNumber}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xB7FCF8E8),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 56.h),

                    // OTP Input Fields - FULLY FUNCTIONAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return Container(
                          width: 58.w,
                          height: 58.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0808),
                            border: Border.all(
                              width: 1.5,
                              color: focusNodes[index].hasFocus
                                  ? const Color(0xFFF5E9B5)
                                  : const Color(0xFFFCF8E8),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              setState(() {});

                              if (value.isNotEmpty && index < 4) {
                                // Move to next field
                                focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                // Move to previous field on backspace
                                focusNodes[index - 1].requestFocus();
                              }

                              // Auto-submit when all fields are filled
                              if (index == 4 && value.isNotEmpty) {
                                final otp = getOTP();
                                if (otp.length == 5) {
                                  FocusScope.of(context).unfocus();
                                  // Optional: Auto-verify after 500ms
                                  // Future.delayed(const Duration(milliseconds: 500), () {
                                  //   _handleVerify(context);
                                  // });
                                }
                              }
                            },
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 56.h),

                    // Resend Code Section - FULLY FUNCTIONAL
                    Center(
                      child: GestureDetector(
                        onTap:
                            isLoading ? null : () => _handleResendOTP(context),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: languageService
                                        .getString('didnt_receive_code') ??
                                    "Didn't receive the code?",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xD8FCF8E8),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.52,
                                ),
                              ),
                              TextSpan(
                                text: '  ',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFCF8E8),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.52,
                                ),
                              ),
                              TextSpan(
                                text:
                                    languageService.getString('resend_code') ??
                                        'Resend Code',
                                style: GoogleFonts.poppins(
                                  color: isLoading
                                      ? const Color(0x80F5E9B5)
                                      : const Color(0xFFF5E9B5),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.56,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Verify Button - FULLY FUNCTIONAL
                    Center(
                      child: GestureDetector(
                        onTap: isLoading ? null : () => _handleVerify(context),
                        child: Container(
                          width: 281.w,
                          height: 54.h,
                          decoration: ShapeDecoration(
                            color: isLoading
                                ? const Color(0x80F5E9B5)
                                : const Color(0xFFF5E9B5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF0A0808),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    languageService.getString('verify') ??
                                        'Verify',
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

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
