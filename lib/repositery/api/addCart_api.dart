import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/addCart_model.dart';

class AddcartApi {
  ApiClient apiClient = ApiClient();

  Future<AddCartModel> getAddCartModel() async {
    String trendingpath = '/cart/user/addToCart';

    var body = {"productId": "6804e14c411ef49d675abd15", "qnt": 1};

    Response response = await apiClient.invokeAPI(
      trendingpath,
      'POST',
      jsonEncode(body),
    );

    return AddCartModel.fromJson(jsonDecode(response.body));
  }
}
