import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modern_grocery/bloc/addDeliveryAddress/bloc/add_delivery_address_bloc.dart';
import 'package:modern_grocery/ui/cart_/cart_two.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String? apiAddress;
  String currentLocation = "Use My Current Location";
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
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    BackButton(color: const Color(0xFFFFFFFF)),
                  ],
                ),
                SizedBox(height: 20.h),
                Center(
                  child: BlocListener<AddDeliveryAddressBloc,
                      AddDeliveryAddressState>(
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
                    child: Text(
                      'Select Delivery Address',
                      style: TextStyle(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 18.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  "Choose Address",
                  style: TextStyle(
                    color: const Color(0xFFFCF8E8),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: selectedAddressType == 'current'
                          ? Color(0xFFF5E9B5)
                          : const Color(0xFFFCF8E8),
                      width: 1.5,
                    ),
                  ),
                  child: RadioListTile<String>(
                    value: 'current',
                    groupValue: selectedAddressType,
                    onChanged: (value) {
                      setState(() {
                        selectedAddressType = value!;
                      });
                    },
                    activeColor: Color(0xFFF5E9B5),
                    title: Text(
                      currentLocation,
                      style: TextStyle(
                          color: const Color(0xFFFCF8E8), fontSize: 14.sp),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 40.h),
                if (apiAddress != null)
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: selectedAddressType == 'api'
                            ? Color(0xFFF5E9B5)
                            : const Color(0xFFFCF8E8),
                        width: 1.5,
                      ),
                    ),
                    child: RadioListTile<String>(
                      value: 'api',
                      groupValue: selectedAddressType,
                      onChanged: (value) {
                        setState(() {
                          selectedAddressType = value!;
                        });
                      },
                      activeColor: Color(0xFFF5E9B5),
                      title: Text(
                        apiAddress!,
                        style: TextStyle(
                            color: const Color(0xFFFCF8E8), fontSize: 14.sp),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                SizedBox(height: 300.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5E9B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    onPressed: () {
                      final selectedAddress = selectedAddressType == 'current'
                          ? currentLocation
                          : apiAddress;

                      if (selectedAddress == null) {
                        _showSnack("Please wait while we fetch addresses.");
                        return;
                      }

                      // Continue with selected address
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartTwo()),
                      );
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
