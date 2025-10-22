import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';

import 'package:modern_grocery/repositery/model/product/getAllProduct.dart';

class GetallproductApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllProduct> getGetAllProduct() async {
    String trendingpath = '/category/get/all';

    var body = {};
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return GetAllProduct.fromJson(response.body as Map<String, dynamic>);
  }
}
