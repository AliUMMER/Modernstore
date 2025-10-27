import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/Login_/verify/verify_bloc.dart';
import 'package:modern_grocery/bloc/Login_/verify/verify_event.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/admin/admin_navibar.dart'; // Ensure this path is correct
import 'package:modern_grocery/ui/location/location_page.dart'; // Ensure this path is correct
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isAdmin = false; // Flag to determine navigation target
  bool isLoadingAdminStatus = true; // Start as true

  @override
  void initState() {
    super.initState();
    _checkAdminStatus(); // Check admin status when screen initializes
    // Auto focus on first field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if widget is still mounted
        focusNodes[0].requestFocus();
      }
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

  // --- Check Admin Status ---
  Future<void> _checkAdminStatus() async {
    // Assume not admin initially, show loading
    setState(() {
      isLoadingAdminStatus = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role');
      final userType = prefs.getString('userType');
      final isAdminFlag = prefs.getBool('isAdmin');

      // Determine if user is admin based on stored values
      final bool isAdminResult = role == 'admin' ||
          role == 'Admin' ||
          userType == 'admin' ||
          userType == 'Admin' ||
          isAdminFlag == true;

      // Update state only if the widget is still mounted
      if (mounted) {
        setState(() {
          isAdmin = isAdminResult;
          isLoadingAdminStatus = false; // Done loading status
        });
      }
    } catch (e) {
      print("Error checking admin status: $e");
      // If error occurs, assume not admin and stop loading
      if (mounted) {
        setState(() {
          isAdmin = false;
          isLoadingAdminStatus = false;
        });
      }
    }
  }

  // --- Handle Verify Button Tap ---
  void _handleVerify(BuildContext context) {
    final otp = getOTP();
    final languageService =
        Provider.of<LanguageService>(context, listen: false);

    // Validate OTP length
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            languageService.getString('please_enter_complete_otp'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Trigger OTP verification BLoC event
    BlocProvider.of<VerifyBloc>(context).add(
      fetchVerifyOTPEvent(
        phoneNumber: widget.phoneNumber,
        otp: otp,
      ),
    );
  }

  // --- Handle Resend Button Tap ---
  void _handleResendOTP(BuildContext context) {
    // Clear existing OTP fields
    for (var controller in otpControllers) {
      controller.clear();
    }
    if (mounted) {
      // Ensure widget is mounted before focusing
      focusNodes[0].requestFocus();
    }

    // Trigger resend OTP BLoC event
    BlocProvider.of<VerifyBloc>(context).add(
      ResendOTPRequested(phoneNumber: widget.phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Show loading indicator while checking admin status ---
    if (isLoadingAdminStatus) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0909),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF5E9B5),
          ),
        ),
      );
    }

    // --- Build UI once admin status is loaded ---
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return BlocListener<VerifyBloc, VerifyState>(
          listener: (context, state) {
            // Dismiss any existing snackbars before showing a new one
            ScaffoldMessenger.of(context).clearSnackBars();

            // --- Handle BLoC States ---
            if (state is VerifySuccess) {
              setState(() => isLoading = false); // Stop loading indicator

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    languageService.getString('verification_success'),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 1), // Shorter duration
                ),
              );

              //
              // --- CORRECTED NAVIGATION LOGIC ---
              // Navigate only AFTER successful verification
              //
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  // Check if widget is still mounted before navigating
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        // Navigate to AdminNavibar if isAdmin, else LocationPage
                        builder: (context) => !isAdmin
                            ? const LocationPage()
                            :  const AdminNavibar()
                      ));
                }
              });
            } else if (state is VerifyError) {
              setState(() => isLoading = false); // Stop loading indicator

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message), // Show error from BLoC
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );

              // Clear OTP fields on error for re-entry
              for (var controller in otpControllers) {
                controller.clear();
              }
              if (mounted) {
                // Check before focusing
                focusNodes[0].requestFocus();
              }
            } else if (state is OTPResent) {
              setState(() => isLoading = false); // Stop loading indicator

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    languageService.getString('otp_resent'),
                  ),
                  backgroundColor: Colors.blue, // Use blue for info
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is VerifyLoading) {
              setState(() => isLoading = true); // Start loading indicator

              // Optional: Show a persistent "Verifying..." SnackBar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Row(
              //       children: [
              //         const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
              //         const SizedBox(width: 20),
              //         Text(languageService.getString('processing')),
              //       ],
              //     ),
              //     duration: const Duration(seconds: 30), // Long duration, cleared on success/error
              //   ),
              // );
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
              // Allows scrolling if keyboard appears
              child: Padding(
                // Consistent horizontal padding
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Column(
                  // --- ALIGNMENT: Main content starts here ---
                  // crossAxisAlignment: CrossAxisAlignment.start ensures children
                  // like Title and Phone Number are aligned to the left.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.h), // Reduced top spacing slightly

                    // --- ALIGNMENT: Title (Left Aligned) ---
                    Text(
                      languageService.getString('enter_verification_code'),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 29.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),
                    Text(
                      languageService.getString('sent_on_whatsapp'),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFF5E9B5),
                        fontSize: 29.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // --- ALIGNMENT: Phone number display (Left Aligned) ---
                    Text(
                      '${languageService.getString('sent_to')} ${widget.phoneNumber}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xB7FCF8E8),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 56.h),

                    // --- ALIGNMENT: OTP Boxes (Row with SpaceBetween) ---
                    // Row arranges children horizontally.
                    // MainAxisAlignment.spaceBetween distributes space evenly *between* the boxes.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          width:
                              58.w, // Slightly smaller width for better spacing
                          height: 58.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0808),
                            border: Border.all(
                              width: 1.w,
                              color: focusNodes[index].hasFocus
                                  ? const Color(
                                      0xFFF5E9B5) // Highlight focused box
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
                              color: Color(0xFFFCF8E8),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              counterText: '', // Hide the counter
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.zero, // Adjust if needed
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            // --- Auto-focus logic ---
                            onChanged: (value) {
                              setState(
                                  () {}); // Update border color on focus change

                              if (value.isNotEmpty && index < 5) {
                                // Check index < 5
                                // Move to next field
                                if (mounted)
                                  focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                // Move to previous field on backspace
                                if (mounted)
                                  focusNodes[index - 1].requestFocus();
                              }

                              // Auto-submit when last field is filled
                              if (index == 5 && value.isNotEmpty) {
                                // Check index == 5
                                final otp = getOTP();
                                if (otp.length == 6) {
                                  FocusScope.of(context)
                                      .unfocus(); // Hide keyboard
                                  // Auto-verify slightly delayed
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    if (mounted) _handleVerify(context);
                                  });
                                }
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 56.h),

                    // --- ALIGNMENT: Resend Code (Centered Horizontally) ---
                    // Center widget centers its child horizontally.
                    Center(
                      child: GestureDetector(
                        onTap:
                            isLoading ? null : () => _handleResendOTP(context),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: languageService
                                    .getString('didnt_receive_code'),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xD8FCF8E8),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' ', // Add space
                                style: GoogleFonts.poppins(fontSize: 13.sp),
                              ),
                              TextSpan(
                                text: languageService.getString('resend_code'),
                                style: GoogleFonts.poppins(
                                  color: isLoading
                                      ? const Color(
                                          0x80F5E9B5) // Dim if loading
                                      : const Color(0xFFF5E9B5), // Accent color
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // --- ALIGNMENT: Verify Button (Centered Horizontally) ---
                    // Center widget centers its child horizontally.
                    Center(
                      child: GestureDetector(
                        // Disable tap while loading
                        onTap: isLoading ? null : () => _handleVerify(context),
                        child: Container(
                          width: 281.w, // Specific width
                          height: 54.h,
                          decoration: ShapeDecoration(
                            // Dim button color while loading
                            color: isLoading
                                ? const Color(0x80F5E9B5)
                                : const Color(0xFFF5E9B5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          child: Center(
                            // Show loading indicator or text
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF0A0808), // Dark color
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    languageService.getString('verify'),
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
                    SizedBox(height: 40.h), // Bottom padding
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
