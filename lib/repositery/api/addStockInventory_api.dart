import 'dart:convert';

import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/addStocksInventory.dart';

class AddstockinventoryApi {
  ApiClient apiClient = ApiClient();

  Future<AddStocksInventory> getaddStockInventory() async {
    String trendingpath = 'http://localhost:4055/api/inventory/addStocks';
    var body = {"productId": "67fbf7d1694818c17b3b6ff7", "stockQnt": 10};

    Response response =
        await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));
    return AddStocksInventory.fromJson(jsonDecode(response.body));
  }
}
