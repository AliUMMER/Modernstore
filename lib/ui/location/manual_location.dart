import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/delivery_/addDeliveryAddress/add_delivery_address_bloc.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/admin/admin_navibar.dart';
import 'package:modern_grocery/ui/bottom_navigationbar.dart';
import 'package:modern_grocery/ui/location/your_location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  bool isAdmin = false;
  bool isLoadingAdminStatus = true;
  String currentLocation = "Use My Current Location";
  String? apiAddress;
  String selectedAddressType = 'current';

  // 🔧 DEVELOPER MODE - Set to false before production
  final bool isDeveloperMode = true;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
    _getCurrentLocation();
  }

  Future<void> _checkAdminStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final role = prefs.getString('role');
      final userType = prefs.getString('userType');
      final isAdminFlag = prefs.getBool('isAdmin');

      print('=== ADMIN STATUS CHECK ===');
      print('role: $role');
      print('userType: $userType');
      print('isAdmin: $isAdminFlag');
      print('All keys: ${prefs.getKeys()}');
      print('========================');

      setState(() {
        isAdmin = role == 'admin' ||
            role == 'Admin' ||
            userType == 'admin' ||
            userType == 'Admin' ||
            isAdminFlag == true;

        isLoadingAdminStatus = false;
      });

      print('✅ Is Admin: $isAdmin');
    } catch (e) {
      print('❌ Error checking admin status: $e');
      setState(() {
        isAdmin = false;
        isLoadingAdminStatus = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final languageService =
          Provider.of<LanguageService>(context, listen: false);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack(languageService.getString('location_services_disabled'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack(languageService.getString('location_permissions_denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnack(
          languageService.getString('location_permissions_permanently_denied'),
          actionLabel: languageService.getString('settings'),
          action: () {
            Geolocator.openAppSettings();
          },
        );
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
      final languageService =
          Provider.of<LanguageService>(context, listen: false);
      _showSnack(
        '${languageService.getString('error_fetching_location')}$e',
      );
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

  // 🔧 DEVELOPER TEST FUNCTIONS
  Future<void> _setAdminMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', 'admin');
    await prefs.setBool('isAdmin', true);
    setState(() {
      isAdmin = true;
    });
    _showSnack('✅ Admin mode activated');
    print('🔧 DEV: Switched to ADMIN mode');
  }

  Future<void> _setUserMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', 'user');
    await prefs.setBool('isAdmin', false);
    setState(() {
      isAdmin = false;
    });
    _showSnack('✅ User mode activated');
    print('🔧 DEV: Switched to USER mode');
  }

  Future<void> _showDebugInfo() async {
    final prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1C1C1C),
        title: Text(
          '🔍 Debug Info',
          style: GoogleFonts.poppins(color: Color(0xFFFCF8E8)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _debugInfoRow('Token', prefs.getString('token')),
              _debugInfoRow('Role', prefs.getString('role')),
              _debugInfoRow('IsAdmin', prefs.getBool('isAdmin').toString()),
              _debugInfoRow('UserId', prefs.getString('userId')),
              _debugInfoRow('Phone', prefs.getString('phone')),
              Divider(color: Color(0xFFF5E9B5)),
              Text(
                'All Keys:',
                style: GoogleFonts.poppins(
                  color: Color(0xFFF5E9B5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                prefs.getKeys().join('\n'),
                style: GoogleFonts.poppins(
                  color: Color(0xFFFCF8E8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(color: Color(0xFFF5E9B5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _debugInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.poppins(
              color: Color(0xFFF5E9B5),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'null',
              style: GoogleFonts.poppins(
                color: Color(0xFFFCF8E8),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingAdminStatus) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0909),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF5E9B5),
          ),
        ),
      );
    }

    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return BlocListener<AddDeliveryAddressBloc, AddDeliveryAddressState>(
          listener: (context, state) {
            if (state is AddDeliveryAddressLoaded) {
              setState(() {
                apiAddress = state.DeliveryData as String?;
              });
            } else if (state is AddDeliveryAddressError) {
              _showSnack(languageService.getString('failed_fetch_address_api'));
            } else if (state is AddDeliveryAddressLoading) {
              _showSnack(languageService.getString('loading_address_api'));
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF0A0909),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    // 🔧 DEVELOPER TESTING PANEL (Only visible in dev mode)
                    if (isDeveloperMode) ...[
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1C),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.bug_report, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  '🔧 Developer Testing Panel',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _setAdminMode,
                                    icon: Icon(Icons.admin_panel_settings,
                                        size: 18),
                                    label: Text('Admin'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isAdmin
                                          ? Color(0xFFF5E9B5)
                                          : Color(0xFF2C2C2C),
                                      foregroundColor: isAdmin
                                          ? Color(0xFF0A0808)
                                          : Color(0xFFFCF8E8),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _setUserMode,
                                    icon: Icon(Icons.person, size: 18),
                                    label: Text('User'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: !isAdmin
                                          ? Color(0xFFF5E9B5)
                                          : Color(0xFF2C2C2C),
                                      foregroundColor: !isAdmin
                                          ? Color(0xFF0A0808)
                                          : Color(0xFFFCF8E8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            OutlinedButton.icon(
                              onPressed: _showDebugInfo,
                              icon: Icon(Icons.info_outline,
                                  color: Color(0xFFF5E9B5)),
                              label: Text(
                                'Show Debug Info',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFFF5E9B5)),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFFF5E9B5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],

                    SizedBox(height: 168.h),

                    // Show admin badge if user is admin
                    if (isAdmin) ...[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5E9B5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.admin_panel_settings,
                                color: Color(0xFF0A0808)),
                            SizedBox(width: 8),
                            Text(
                              'Admin Mode',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF0A0808),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],

                    Text(
                      languageService.getString('select_delivery_address'),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFCF8E8),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 23.h),
                    _buildSearchBox(languageService),
                    SizedBox(height: 46.h),
                    _buildAddressRadioSelection(languageService),
                    SizedBox(height: 46.h),
                    _buildAddNewAddress(languageService),
                    SizedBox(height: 200.h),
                    _buildConfirmButton(languageService),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBox(LanguageService languageService) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFCF8E8), width: 2.w),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: GoogleFonts.poppins(color: Color(0x91FCF8E8)),
        decoration: InputDecoration(
          hintText: languageService.getString('search_for_area'),
          hintStyle:
              GoogleFonts.poppins(color: Color(0x91FCF8E8), fontSize: 12.sp),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Color(0x91FCF8E8)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildAddressRadioSelection(LanguageService languageService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageService.getString('choose_address'),
          style: GoogleFonts.poppins(
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
          style: GoogleFonts.poppins(
              color: const Color(0xFFFCF8E8), fontSize: 14.sp),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildAddNewAddress(LanguageService languageService) {
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
          child: Text(
            languageService.getString('add_new_address'),
            style:
                GoogleFonts.poppins(color: Color(0xE8FCF8E8), fontSize: 15.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(LanguageService languageService) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          String chosenAddress = selectedAddressType == 'current'
              ? currentLocation
              : (apiAddress ?? '');

          print('📍 Chosen Address: $chosenAddress');
          print('👤 Is Admin: $isAdmin');

          if (isAdmin) {
            print('🔐 Navigating to Admin Panel');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminNavibar()),
            );
          } else {
            print('👥 Navigating to User Home');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationBarWidget()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5E9B5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
        ),
        child: Text(
          languageService.getString('confirm address'),
          style: GoogleFonts.poppins(
            color: Color(0xFF0A0808),
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
