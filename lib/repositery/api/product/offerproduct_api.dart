import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/product/offerproduct%20model.dart';

class OfferproductApi {
  ApiClient apiClient = ApiClient();

  Future<OfferproductModel> getOfferproductModel() async {
    String trendingpath = '/product/get/best-offer/items';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    // Decode the response body here
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    // Pass decoded JSON to the model
    return OfferproductModel.fromJson(decodedJson);
  }
}
