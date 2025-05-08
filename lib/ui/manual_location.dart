import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:modern_grocery/bloc/addDeliveryAddress/bloc/add_delivery_address_bloc.dart';
import 'package:modern_grocery/ui/admin_navibar.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/your_location.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  bool isAdmin = false; // Default is user
  String currentLocation = "Use My Current Location";
  String? apiAddress;
  String selectedAddressType = 'current'; // 'current' or 'api'

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    context.read<AddDeliveryAddressBloc>().add(fetchAddDeliveryAddress());
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack('Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnack('Location permissions are permanently denied.',
            actionLabel: 'Settings', action: () {
          Geolocator.openAppSettings();
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      setState(() {
        currentLocation = address;
      });
    } catch (e) {
      _showSnack('Error fetching location: $e');
    }
  }

  void _showSnack(String message, {String? actionLabel, VoidCallback? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: actionLabel != null
            ? SnackBarAction(label: actionLabel, onPressed: action!)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDeliveryAddressBloc, AddDeliveryAddressState>(
      listener: (context, state) {
        if (state is AddDeliveryAddressLoaded) {
          setState(() {
            apiAddress = state.addDeliveryAddress.data!.address;
          });
        } else if (state is AddDeliveryAddressError) {
          _showSnack('Failed to fetch address from API');
        } else if (state is AddDeliveryAddressLoading) {
          _showSnack('Loading address from API...');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0909),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 168.h),
                Text(
                  'Select Delivery Address',
                  style: TextStyle(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 23.h),
                _buildSearchBox(),
                SizedBox(height: 46.h),
                _buildAddressRadioSelection(),
                SizedBox(height: 46.h),
                _buildAddNewAddress(),
                SizedBox(height: 200.h),
                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFCF8E8), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: const TextStyle(color: Color(0x91FCF8E8)),
        decoration: InputDecoration(
          hintText: "Search for area...",
          hintStyle: const TextStyle(color: Color(0x91FCF8E8), fontSize: 12),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Color(0x91FCF8E8)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildAddressRadioSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Address",
          style: TextStyle(
            color: const Color(0xFFFCF8E8),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        _buildRadioTile(
          value: 'current',
          title: currentLocation,
        ),
        SizedBox(height: 20.h),
        if (apiAddress != null)
          _buildRadioTile(
            value: 'api',
            title: apiAddress!,
          ),
      ],
    );
  }

  Widget _buildRadioTile({required String value, required String title}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: selectedAddressType == value
              ? const Color(0xFFF5E9B5)
              : const Color(0xFFFCF8E8),
          width: 1.5,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: selectedAddressType,
        onChanged: (val) {
          setState(() {
            selectedAddressType = val!;
          });
        },
        activeColor: const Color(0xFFF5E9B5),
        title: Text(
          title,
          style: TextStyle(color: const Color(0xFFFCF8E8), fontSize: 14.sp),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildAddNewAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.add, color: Color(0xE8FCF8E8)),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const YourLocation()),
            );
          },
          child: const Text(
            "Add new address",
            style: TextStyle(color: Color(0xE8FCF8E8), fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          String chosenAddress = selectedAddressType == 'current'
              ? currentLocation
              : (apiAddress ?? '');

          print('Chosen Address: $chosenAddress');

          if (!isAdmin) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminNavibar()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationBarWidget()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5E9B5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text(
          "Confirm address",
          style: TextStyle(
            color: Color(0xFF0A0808),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
