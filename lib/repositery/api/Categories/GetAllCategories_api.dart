import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/Categories/GetAllCategoriesModel.dart';


class GetallcategoriesApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllCategoriesModel> getGetAllCategories() async {
 String trendingpath = '/category/get/all';
   

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', null,);

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    return GetAllCategoriesModel.fromJson(decodedJson);
  }
}
