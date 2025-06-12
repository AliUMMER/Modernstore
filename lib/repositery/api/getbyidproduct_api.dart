import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getByIdProduct.dart';

class GetbyidproductApi {
  final ApiClient apiClient;

  GetbyidproductApi({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  Future<GetByIdProduct> getGetByIdProduct(String productId) async {
    if (productId.isEmpty) {
      throw Exception('Product ID cannot be empty');
    }
    String path = '/product/getby/$productId';
    var body = {};
    Response response = await apiClient.invokeAPI(path, 'GET', body);
    print('API Response for product $productId: ${response.body}');
    Map<String, dynamic> jsonData = json.decode(response.body);
    return GetByIdProduct.fromJson(jsonData);
  }
}
