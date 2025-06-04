import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return const Center(child: CircularProgressIndicator());
        }
        if (profileState is UserprofileError) {
          return const Center(child: Text('User profile unavailable'));
        }
        if (profileState is Userprofileloaded) {
          _profileData = BlocProvider.of<UserprofileBloc>(context).getUserProfile;

          return BlocBuilder<UserdeliveryaddressBloc, UserdeliveryaddressState>(
            builder: (context, addressState) {
              if (addressState is UserdeliveryaddressLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (addressState is UserdeliveryaddressError) {
                return const Center(child: Text('Delivery address unavailable'));
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
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Profile image widget if needed
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  size: 16, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _profileData?.user?.name ?? 'User Name',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffC4C1B4)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Name",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 5),
                              buildEditableField(controller: nameController),
                              const SizedBox(height: 20),
                              const Text("Phone number",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 5),
                              buildEditableField(controller: phoneController),
                              const SizedBox(height: 20),
                              const Text("Address",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 5),
                              buildEditableField(
                                  controller: addressController, maxLines: 3),
                              const SizedBox(height: 30),
                              // Add your Save button here if needed
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC4C1B4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: const TextStyle(color: Color(0xffC4C1B4)),
              decoration: const InputDecoration(
                hintText: '',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.edit, color: Color(0xffC4C1B4), size: 18),
        ],
      ),
    );
  }
}
