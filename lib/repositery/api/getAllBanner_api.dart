import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/api/getallproduct_api.dart';
import 'package:modern_grocery/repositery/model/getAllBanner%20Model.dart';

class GetallbannerApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllBannerModel> getGetAllBannerModel() async {
    String tendingpath = '/banner/get/all';

    var body = {};

    Response response = await apiClient.invokeAPI(tendingpath, 'GET', body);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return GetAllBannerModel.fromJson(jsonResponse);
  }
}
