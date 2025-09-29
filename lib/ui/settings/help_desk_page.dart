import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:modern_grocery/services/language_service.dart'; // ✅ Add this import

class HelpDeskPage extends StatefulWidget {
  const HelpDeskPage({super.key});

  @override
  State<HelpDeskPage> createState() => _HelpDeskPageState();
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  late LanguageService languageService; // ✅ Declare service
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    languageService = LanguageService(); // ✅ Initialize service
  }

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    _showSnackBar(
        '${languageService.getString('email')}: support@modernstore.com\n'
        '${languageService.getString('subject')}: ${_subjectController.text}\n'
        '${languageService.getString('message')}: ${_messageController.text}');
  }

  Future<void> _launchPhone() async {
    _showSnackBar(
        '${languageService.getString('phone')}: +1 (234) 567-890\n'
        '${languageService.getString('tap_to_call')}');
  }

  Future<void> _launchWhatsApp() async {
    _showSnackBar(
        '${languageService.getString('whatsapp')}: +1 (234) 567-890\n'
        '${languageService.getString('tap_to_open_whatsapp')}');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFF5E9B5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0909),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E9B5)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          languageService.getString('help_support'), // "Help & Support"
          style: GoogleFonts.poppins(
            color: const Color(0xFFF5E9B5),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Methods
            _buildSection(languageService.getString('contact_us'), [
              _buildContactCard(
                icon: Icons.email,
                title: languageService.getString('email_support'),
                subtitle: 'support@modernstore.com',
                onTap: _launchEmail,
              ),
              _buildContactCard(
                icon: Icons.phone,
                title: languageService.getString('phone_support'),
                subtitle: '+1 (234) 567-890',
                onTap: _launchPhone,
              ),
              _buildContactCard(
                icon: Icons.chat,
                title: 'WhatsApp',
                subtitle: languageService.getString('chat_with_us'),
                onTap: _launchWhatsApp,
              ),
            ]),

            SizedBox(height: 30.h),

            // FAQ Section
            _buildSection(languageService.getString('faq_title'), [
              _buildFAQItem(
                languageService.getString('faq_how_to_order'),
                languageService.getString('faq_how_to_order_answer'),
              ),
              _buildFAQItem(
                languageService.getString('faq_delivery_times'),
                languageService.getString('faq_delivery_times_answer'),
              ),
              _buildFAQItem(
                languageService.getString('faq_track_order'),
                languageService.getString('faq_track_order_answer'),
              ),
              _buildFAQItem(
                languageService.getString('faq_return_policy'),
                languageService.getString('faq_return_policy_answer'),
              ),
            ]),

            SizedBox(height: 30.h),

            // Send Message Section
            _buildSection(languageService.getString('send_message'), [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: const Color(0xffC4C1B4)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _subjectController,
                      style: GoogleFonts.inter(color: const Color(0xFFFCF8E8)),
                      decoration: InputDecoration(
                        labelText: languageService.getString('subject'),
                        labelStyle:
                            GoogleFonts.inter(color: const Color(0xFFF5E9B5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFF5E9B5)),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextField(
                      controller: _emailController,
                      style: GoogleFonts.inter(color: const Color(0xFFFCF8E8)),
                      decoration: InputDecoration(
                        labelText: languageService.getString('your_email'),
                        labelStyle:
                            GoogleFonts.inter(color: const Color(0xFFF5E9B5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFF5E9B5)),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextField(
                      controller: _messageController,
                      maxLines: 4,
                      style: GoogleFonts.inter(color: const Color(0xFFFCF8E8)),
                      decoration: InputDecoration(
                        labelText: languageService.getString('message'),
                        labelStyle:
                            GoogleFonts.inter(color: const Color(0xFFF5E9B5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffC4C1B4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFF5E9B5)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _launchEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5E9B5),
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          languageService.getString('send_message_button'),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0A0909),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xFFF5E9B5),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 15.h),
        ...children,
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color(0xffC4C1B4)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFF5E9B5), size: 24.sp),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFFFCF8E8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            color: const Color(0xFFFCF8E8).withOpacity(0.7),
            fontSize: 14.sp,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 16.sp,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color(0xffC4C1B4)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.inter(
            color: const Color(0xFFFCF8E8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              answer,
              style: GoogleFonts.inter(
                color: const Color(0xFFFCF8E8).withOpacity(0.8),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
        iconColor: const Color(0xFFF5E9B5),
        collapsedIconColor: const Color(0xFFF5E9B5),
      ),
    );
  }
}