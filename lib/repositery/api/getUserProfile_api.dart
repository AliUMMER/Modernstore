import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getUserProfile.dart';

class GetuserprofileApi {
  ApiClient apiClient = ApiClient();

  Future<GetUserProfile> getGetUserProfile() async {
    String trendingpath = 'http://localhost:4055/api/user/profile';
    var body = {};

    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);
    return GetUserProfile.fromJson(json as Map<String, dynamic>);
  }
}
