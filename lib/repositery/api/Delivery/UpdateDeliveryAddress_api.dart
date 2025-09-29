import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/updateDeliveryAddress.dart';

class UpdateDeliveryAddressapi {
  ApiClient apiClient = ApiClient();

  Future<UpdateDeliveryAddress> getUpdateAddress() async {
    String trendingpath =
        '/user/update-delivery-address/68092f3a6649ccf83c38958b';

    var body = {
      "address": "Root-sys, SkyMall, Edarikkode, Kottakkal",
      "city": "Kottakkal",
      "pincode": "123456",
      "latitude": "1.00000000000000",
      "longitude": "2.0000000000000"
    };

    Response response =
        await apiClient.invokeAPI(trendingpath, 'PUT', jsonEncode(body));

    return UpdateDeliveryAddress.fromJson(jsonDecode(response.body));
  }
}
