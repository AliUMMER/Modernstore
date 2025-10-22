import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/Banner/getAllBanner%20Model.dart';

class GetallbannerApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllBannerModel> getGetAllBannerModel() async {
    String trendingPath ='/banner/get/all';
    var body = {};

    try {
      Response response = await apiClient.invokeAPI(trendingPath, 'GET', body);

      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return GetAllBannerModel.fromJson(decodedJson);
    } catch (e) {
      print('API Error in GetallbannerApi: $e');
      throw Exception('Network error: $e');
    }
  }
}
