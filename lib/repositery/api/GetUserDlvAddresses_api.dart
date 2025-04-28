import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getUserDlvAddresses.dart';

class GetUserDlvAddressesapi {
  ApiClient apiClient = ApiClient();

  Future<GetUserDlvAddresses> getGetUserDlvAddresses() async {
    String tendingpath =
        'http://localhost:4055/api/user/get-delivery-addresses';

    var body = {};

    Response response = await apiClient.invokeAPI(tendingpath, 'GET', body);

    return GetUserDlvAddresses.fromJson(json as Map<String, dynamic>);
  }
}
