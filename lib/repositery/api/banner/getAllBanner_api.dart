import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getAllBanner%20Model.dart';

class GetallbannerApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllBannerModel> getGetAllBannerModel() async {
    String trendingPath = '/banner/get/all';
    var body = {};

    try {
      Response response = await apiClient.invokeAPI(trendingPath, 'GET', body);

      // Check if response is successful
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return GetAllBannerModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        // Handle authentication error
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        throw Exception(
            'Authentication failed: ${errorResponse['message'] ?? 'Invalid token'}');
      } else {
        // Handle other HTTP errors
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error in GetallbannerApi: $e');
      throw Exception('Network error: $e');
    }
  }
}
