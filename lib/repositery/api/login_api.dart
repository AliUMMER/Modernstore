import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/login_model.dart';

class Loginapi {
  ApiClient apiclient = ApiClient();

  Future<Login> getLogin() async {
    String trendingpath = '/auth/login';

    var body = {"phoneNumber": "1101010100", "otp": "573201"};

    Response response = await apiclient.invokeAPI(
      trendingpath,
      'POST',
      jsonEncode(body),
    );

    return Login.fromJson(jsonDecode(response.body));
  }
}
