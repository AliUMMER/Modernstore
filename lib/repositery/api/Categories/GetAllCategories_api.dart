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

    // ✅ Parse JSON correctly
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    // ✅ Now pass the parsed map to the model
    return GetAllCategoriesModel.fromJson(decodedJson);
  }
}
