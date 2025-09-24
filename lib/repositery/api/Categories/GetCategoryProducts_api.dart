import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/GetCategoryProducts_model.dart';

class GetcategoryproductsApi {
  ApiClient apiClient = ApiClient();

  Future<GetCategoryProductsModel> getCategoryProductsById(String catId) async {
    String path = '/product/get/category/items/$catId';

    Response response = await apiClient.invokeAPI(path, 'GET', null);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return GetCategoryProductsModel.fromJson(jsonData);
  }
}

