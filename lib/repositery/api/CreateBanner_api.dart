import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/CreateBanner_model.dart';

class CreatebannerApi {
  ApiClient apiClient = ApiClient();

  Future<CreateBannerModel> getCreateBannerModel() async {
    String trendingpath = '/banner/create';
    var body = {};

    Response response = await apiClient.invokeAPI(
      trendingpath,
      'POST',
      jsonEncode(body),
    );

    return CreateBannerModel.fromJson(jsonDecode(response.body));
  }
}
