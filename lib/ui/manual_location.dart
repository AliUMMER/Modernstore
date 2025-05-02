import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Add this for reverse geocoding
import 'package:modern_grocery/ui/admin_navibar.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/your_location.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  bool isAdmin = true; // Default is user
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 168.h),
              Text(
                'Enter Your Location',
                style: TextStyle(
                  color: const Color(0xFFF5E9B5),
                  fontSize: 23,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 23.h),
              _buildSearchBox(),
              SizedBox(height: 46.h),
              _buildLocationTile(
                Icons.my_location,
                "Use my current location",
                currentLocation,
              ),
              SizedBox(height: 46.h),
              _buildAddNewAddress(),
              SizedBox(height: 46.h),
              _buildSavedAddresses(),
              SizedBox(height: 200.h),
              _buildConfirmButton(),
              SizedBox(height: 20.h),
            ],
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

  Widget _buildLocationTile(IconData icon, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        if (title == "Use my current location") {
          _getCurrentLocation(); // Call the method to fetch location
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFCF8E8), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xE8FCF8E8)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xE8FCF8E8),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style:
                      const TextStyle(color: Color(0x91FCF8E8), fontSize: 13),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildSavedAddresses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Saved addresses",
              style: TextStyle(
                color: Color(0xE8FCF8E8),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "Manage",
              style: TextStyle(color: Color(0xE8FCF8E8), fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildLocationTile(
          Icons.location_on,
          "Tirur",
          "Tirur ezhur road, 44 villa...",
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
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
