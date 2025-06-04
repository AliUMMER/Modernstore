import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getUserProfile.dart';

class GetuserprofileApi {
  ApiClient apiClient = ApiClient();

  Future<GetUserProfile> getGetUserProfile() async {
    String trendingpath = '/user/profile';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return GetUserProfile.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load user profile. Status: ${response.statusCode}');
    }
  }
}
