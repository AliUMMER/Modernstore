import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/GetAllCategoriesModel.dart';

class GetallcategoriesApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllCategoriesModel> getGetAllCategories() async {
    String trendingpath = '/category/get/all';

    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return GetAllCategoriesModel.fromJson(json as Map<String, dynamic>);
  }
}
