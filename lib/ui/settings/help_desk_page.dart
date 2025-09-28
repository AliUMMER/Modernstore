import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpDeskPage extends StatefulWidget {
  const HelpDeskPage({super.key});

  @override
  State<HelpDeskPage> createState() => _HelpDeskPageState();
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    _showSnackBar(
        'Email: support@modernstore.com\nSubject: ${_subjectController.text}\nMessage: ${_messageController.text}');
  }

  Future<void> _launchPhone() async {
    _showSnackBar('Phone: +1 (234) 567-890\nTap to call this number');
  }

  Future<void> _launchWhatsApp() async {
    _showSnackBar('WhatsApp: +1 (234) 567-890\nTap to open WhatsApp chat');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFF5E9B5),
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
          'Help & Support',
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
            _buildSection('Contact Us', [
              _buildContactCard(
                icon: Icons.email,
                title: 'Email Support',
                subtitle: 'support@modernstore.com',
                onTap: _launchEmail,
              ),
              _buildContactCard(
                icon: Icons.phone,
                title: 'Phone Support',
                subtitle: '+1 (234) 567-890',
                onTap: _launchPhone,
              ),
              _buildContactCard(
                icon: Icons.chat,
                title: 'WhatsApp',
                subtitle: 'Chat with us instantly',
                onTap: _launchWhatsApp,
              ),
            ]),

            SizedBox(height: 30.h),

            // FAQ Section
            _buildSection('Frequently Asked Questions', [
              _buildFAQItem(
                'How do I place an order?',
                'Simply browse our products, add items to cart, and proceed to checkout. You can pay using various methods including credit cards, digital wallets, or cash on delivery.',
              ),
              _buildFAQItem(
                'What are your delivery times?',
                'We offer same-day delivery for orders placed before 2 PM. Standard delivery takes 1-2 business days.',
              ),
              _buildFAQItem(
                'How can I track my order?',
                'You can track your order in real-time through the app. Go to "My Orders" section and click on your order to see its current status.',
              ),
              _buildFAQItem(
                'What is your return policy?',
                'We offer a 30-day return policy for most items. Items must be in original condition with tags attached.',
              ),
            ]),

            SizedBox(height: 30.h),

            // Send Message Section
            _buildSection('Send us a Message', [
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
                        labelText: 'Subject',
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
                        labelText: 'Your Email',
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
                        labelText: 'Message',
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
                          'Send Message',
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
