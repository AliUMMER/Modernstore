import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/getAllProduct.dart';

class GetallproductApi {
  ApiClient apiClient = ApiClient();

  Future<GetAllProduct> getGetAllProduct() async {
    String trendingpath = 'http://localhost:4055/api/product/all';

    var body = {};
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return GetAllProduct.fromJson(response.body as Map<String, dynamic>);
  }
}
