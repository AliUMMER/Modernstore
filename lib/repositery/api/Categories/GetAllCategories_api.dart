import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/main.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/GetAllCategoriesModel.dart';

class GetallcategoriesApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllCategoriesModel> getGetAllCategories() async {
    String trendingpath = '$basePath/category/get/all';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    return GetAllCategoriesModel.fromJson(decodedJson);
  }
}
