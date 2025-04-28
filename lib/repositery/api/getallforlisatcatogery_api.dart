import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getAllForListCategory.dart';

class GetAllForListCategoryApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllForListCategory> getGetAllForListCategory() async {
    String url = 'http://localhost:4055/api/category/get/all/list';

    Response response = await apiClient.invokeAPI(
      url,
      'GET',
      null,
    );

    return GetAllForListCategory.fromJson(jsonDecode(response.body));
  }
}
