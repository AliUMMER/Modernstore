import 'dart:convert';

import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginapi {
  final ApiClient apiclient = ApiClient();
  final String loginPath = '/auth/login';

  Future<Loginmodel> getLogin({
    required String phoneNumber,
  }) async {
    try {
      final body = {
        "phoneNumber": phoneNumber.trim(),
        "otp": "573201",
      };

      print(' Sending OTP request...');
      print(' Phone: "$phoneNumber"');
      print(' Body: $body');

      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        body,
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      print('OTP sent successfully');
      return loginmodel;
    } catch (e) {
      print(' Error in Send OTP API: $e');
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<Loginmodel> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final body = {
        "phoneNumber": phoneNumber.trim(),
        "otp": otp.trim(),
      };

      print(' Verifying OTP...');
      print(' Phone: "$phoneNumber"');
      print('OTP: "$otp"');
      print(' Body: $body');

      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        body,
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      if (loginmodel.accessToken.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", loginmodel.accessToken);
        await prefs.setString("phone", loginmodel.user.phoneNumber);
        await prefs.setString("userId", loginmodel.user.id);
        final userRole = loginmodel.user.role;
        await prefs.setString('role', userRole);

        final isAdmin = userRole.toLowerCase() == 'admin';
        await prefs.setBool('isAdmin', isAdmin);

        if (loginmodel.user.name != null) {
          await prefs.setString('userName', loginmodel.user.name);
        }

        print('User role: $userRole');
        print('Is Admin: $isAdmin');
        print('userId:${loginmodel.user.id}');
        print('Token saved successfully: ${loginmodel.accessToken}');

        print('VERIFICATION');
        print('Stored Token: ${prefs.getString("token")}');
        print('Stored Role: ${prefs.getString("role")}');
        print('Stored IsAdmin: ${prefs.getBool("isAdmin")}');
      } else {
        print(' No token received in response.');
      }
      print(' OTP verified successfully');
      return loginmodel;
    } catch (e) {
      print(' Error in Verify OTP API: $e');
      throw Exception("Failed to verify OTP: $e");
    }
  }
}
