import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getUserDlvAddresses.dart';

class GetUserDlvAddressesapi {
  ApiClient apiClient = ApiClient();

  Future<GetUserDlvAddresses> getGetUserDlvAddresses() async {
    // Just the relative path here (no protocol or host)
    String tendingpath = '/user/get-delivery-addresses';

    // If your API needs query params or body for GET, add accordingly (usually empty for GET)
    Map<String, dynamic> body = {};

    Response response = await apiClient.invokeAPI(tendingpath, 'GET', body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return GetUserDlvAddresses.fromJson(jsonMap);
    } else {
      throw Exception(
          'Failed to load delivery addresses. Status code: ${response.statusCode}');
    }
  }
}
