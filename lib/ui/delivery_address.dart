import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modern_grocery/bloc/addDeliveryAddress/bloc/add_delivery_address_bloc.dart';
import 'package:modern_grocery/ui/cart_two.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  dynamic address;
  String currentLocation = "Tirur"; // Default location

  // Fetch current location using geolocator and convert to address
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Location services are disabled. Please enable them.')),
        );
        return;
      }

      // Check for location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Location permissions are permanently denied. Please enable them in settings.'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: () {
                Geolocator.openAppSettings();
              },
            ),
          ),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode to get a readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      setState(() {
        currentLocation = address; // Update with the readable address
      });

      // Dispatch event to AddDeliveryAddressBloc
      context.read<AddDeliveryAddressBloc>();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with design size (e.g., 375x812 for iPhone X)
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
                    listener: (context, state) async {
                      if (state is AddDeliveryAddressLoaded) {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const CartTwo()),
                        // );
                        address = state.addDeliveryAddress.data!.address;
                      } else if (state is AddDeliveryAddressError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Location not accessed.'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.w),
                          ),
                        );
                      } else if (state is AddDeliveryAddressLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const CircularProgressIndicator(
                                    color: Colors.white),
                                SizedBox(width: 20.w),
                                const Text('Processing...'),
                              ],
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16.w),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Select Delivery Address',
                      style: TextStyle(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 18.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFFCF8E8), width: 2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    style: TextStyle(color: const Color(0x91FCF8E8)),
                    decoration: InputDecoration(
                      hintText: "Search for area...",
                      hintStyle: TextStyle(
                          color: const Color(0x91FCF8E8), fontSize: 12.sp),
                      border: InputBorder.none,
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0x91FCF8E8)),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 10.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: _getCurrentLocation,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      const Icon(Icons.my_location,
                          color: Color(0xE8FCF8E8), size: 24),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          currentLocation,
                          style: TextStyle(
                            color: const Color(0xFFFCF8E8),
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                if (address != null)
                  Text(
                    address,
                    style: TextStyle(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    const Icon(Icons.add, color: Color(0xE8FCF8E8), size: 24),
                    SizedBox(width: 10.w),
                    Text(
                      'Add address',
                      style: TextStyle(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100.h),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const CartTwo()),
                      // );
                      context
                          .read<AddDeliveryAddressBloc>()
                          .add(fetchAddDeliveryAddress());
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
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
