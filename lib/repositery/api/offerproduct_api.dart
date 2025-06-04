import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/offerproduct%20model.dart';

class OfferproductApi {
  ApiClient apiClient = ApiClient();

  Future<OfferproductModel> getOfferproductModel() async {
    String trendingpath = '/product/get/best-offer/items';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);
    return OfferproductModel.fromJson(json as Map<String, dynamic>);
  }
}
