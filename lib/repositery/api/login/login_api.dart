import 'dart:convert';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginapi {
  ApiClient apiclient = ApiClient();

  String loginPath = '/auth/login';

  Future<Loginmodel> getLogin({
    required String phoneNumber,
  }) async {
    try {
      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        {
          "phoneNumber": int.parse(phoneNumber),
        },
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      return loginmodel;
    } catch (e) {
      print('Error in Send OTP Api: $e');
      throw Exception("Failed to send OTP: $e");
    }
  }

  Future<Loginmodel> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await apiclient.invokeAPI(
        loginPath,
        'POST',
        {
          "phoneNumber": int.parse(phoneNumber),
          "otp": int.parse(otp),
        },
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      final Loginmodel loginmodel = Loginmodel.fromJson(jsonMap);

      // Save token only after successful verification
      if (loginmodel.accessToken.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", loginmodel.accessToken);
        await prefs.setString('phone', loginmodel.user.phoneNumber);
      }

      return loginmodel;
    } catch (e) {
      print('Error in Verify OTP Api: $e');
      throw Exception("Failed to verify OTP: $e");
    }
  }
}
