import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getByIdProduct.dart';

class GetbyidproductApi {
  ApiClient apiClient = ApiClient();

  Future<GetByIdProduct> getGetByIdProduct() async {
    String trendingpath =
        'http://localhost:4055/api/product/getby/67fbf7d1694818c17b3b6ff7';

    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);
    return GetByIdProduct.fromJson(json as Map<String, dynamic>);
  }
}
