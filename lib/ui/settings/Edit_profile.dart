import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/userdelivery%20addrees/userdeliveryaddress_bloc.dart';
import 'package:modern_grocery/bloc/userprofile/bloc/userprofile_bloc.dart';

import 'package:modern_grocery/repositery/model/getUserDlvAddresses.dart';
import 'package:modern_grocery/repositery/model/getUserProfile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  bool _controllersInitialized = false;

  GetUserProfile? _profileData;
  GetUserDlvAddresses? _addressData;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserprofileBloc>(context).add(fetchUserprofile());
    BlocProvider.of<UserdeliveryaddressBloc>(context)
        .add(fetchUserdeliveryaddressEvent());
  }

  @override
  void dispose() {
    if (_controllersInitialized) {
      nameController.dispose();
      phoneController.dispose();
      addressController.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    nameController =
        TextEditingController(text: _profileData?.user?.name ?? '');
    phoneController =
        TextEditingController(text: _profileData?.user?.phoneNumber ?? '');

    // Assuming delivery address is a string, adjust if you have a list or complex type
    String deliveryAddress = '';
    if (_addressData != null &&
        _addressData!.data != null &&
        _addressData!.data!.isNotEmpty) {
      // For example, take first address line
      deliveryAddress = _addressData!.data![0].address ?? '';
    }
    addressController = TextEditingController(text: deliveryAddress);

    _controllersInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserprofileBloc, UserprofileState>(
      builder: (context, profileState) {
        if (profileState is Userprofileloading) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0909),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (profileState is UserprofileError) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0909),
            body: Center(
              child: Text(
                'User profile unavailable',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          );
        }
        if (profileState is Userprofileloaded) {
          _profileData = BlocProvider.of<UserprofileBloc>(context).getUserProfile;

          return BlocBuilder<UserdeliveryaddressBloc, UserdeliveryaddressState>(
            builder: (context, addressState) {
              if (addressState is UserdeliveryaddressLoading) {
                return Scaffold(
                  backgroundColor: const Color(0xFF0A0909),
                  body: const Center(child: CircularProgressIndicator()),
                );
              }
              if (addressState is UserdeliveryaddressError) {
                return Scaffold(
                  backgroundColor: const Color(0xFF0A0909),
                  body: Center(
                    child: Text(
                      'Delivery address unavailable',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                );
              }
              if (addressState is UserdeliveryaddressLoaded) {
                _addressData =
                    BlocProvider.of<UserdeliveryaddressBloc>(context).getUserDlvAddresses;

                if (!_controllersInitialized) {
                  _initializeControllers();
                }

                return Scaffold(
                  backgroundColor: const Color(0xFF0A0909),
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF0A0909),
                    elevation: 0,
                    leading: const BackButton(color: Colors.white),
                    title: Text(
                      'Edit Profile',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Profile image widget if needed
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          _profileData?.user?.name ?? 'User Name',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffC4C1B4)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              buildEditableField(controller: nameController),
                              SizedBox(height: 20.h),
                              Text(
                                "Phone number",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              buildEditableField(controller: phoneController),
                              SizedBox(height: 20.h),
                              Text(
                                "Address",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              buildEditableField(
                                  controller: addressController, maxLines: 3),
                              SizedBox(height: 30.h),
                              // Save button
                              SizedBox(
                                width: double.infinity,
                                height: 50.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add save functionality here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFCF8E8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Save Changes',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF0A0909),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget buildEditableField({
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC4C1B4)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: GoogleFonts.inter(
                color: const Color(0xffC4C1B4),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Icon(
            Icons.edit,
            color: const Color(0xffC4C1B4),
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}