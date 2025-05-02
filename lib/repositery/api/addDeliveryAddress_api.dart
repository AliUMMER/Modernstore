import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/addDeliveryAddress.dart';

class AddDeliveryAddressApi {
  ApiClient apiClient = ApiClient();

  Future<AddDeliveryAddress> getaddDeliveryAddress() async {
    String url = '/user/add-delivery-address';

    var body = {
      "address": "Root-sys, SkyMall, Edarikkode, Kottakkal",
      "city": "Edarikkode",
      "pincode": "123456",
      "latitude": "1.00000000000000",
      "longitude": "2.0000000000000"
    };

    Response response = await apiClient.invokeAPI(
      url,
      'POST',
      jsonEncode(body),
    );

    print('adddelivery addresssss   $body');

    return AddDeliveryAddress.fromJson(jsonDecode(response.body));
  }
}
