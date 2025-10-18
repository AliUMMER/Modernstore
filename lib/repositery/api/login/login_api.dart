import 'dart:convert';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginapi {
  ApiClient apiclient = ApiClient();

  String loginPath = '/auth/login';

  // Send OTP to phone number
  Future<Loginmodel> getLogin({
    required String phoneNumber,
  }) async {
    try {
      // METHOD 1: Use explicit string typing
      final body = {
        "phoneNumber": phoneNumber.toString(), // Force string
        "otp": "", // Empty string
      };

      print(' Sending OTP request');
      print(' Phone: "$phoneNumber" (type: ${phoneNumber.runtimeType})');
      print('Body before API: $body');

      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        body,
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      print(' OTP sent successfully');
      return loginmodel;
    } catch (e) {
      print(' Error in Send OTP Api: $e');
      throw Exception("Failed to send OTP: $e");
    }
  }

  // Verify OTP
  Future<Loginmodel> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final body = {
        "phoneNumber": phoneNumber.toString(), // Force string
        "otp": otp.toString(), // Force string
      };

      print(' Verifying OTP');
      print(' Phone: "$phoneNumber" (type: ${phoneNumber.runtimeType})');
      print(' OTP: "$otp" (type: ${otp.runtimeType})');
      print('Body before API: $body');

      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        body,
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      // Save token only after successful verification
      if (loginmodel.accessToken.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", loginmodel.accessToken);
        await prefs.setString('phone', loginmodel.user.phoneNumber);
        print(' Token saved successfully');
      }

      print('OTP verified successfully');
      return loginmodel;
    } catch (e) {
      print(' Error in Verify OTP Api: $e');
      throw Exception("Failed to verify OTP: $e");
    }
  }
}
