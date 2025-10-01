import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/main.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getAllnventory.dart';

class GetAllInventoryApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllnventory> getGetAllnventory() async {
    String url = '$basePath/inventory/get/all/list';
    Response response = await apiClient.invokeAPI(
      url,
      'GET',
      null,
    );

    return GetAllnventory.fromJson(jsonDecode(response.body));
  }
}
