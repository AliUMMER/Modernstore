import 'package:modern_grocery/repositery/api/api_client.dart';

class RemovewishlistApi {
  ApiClient _apiClient = ApiClient();
  Future<void> removewish(String productId) async {
    String tendingpath = "/wishlist/delete/$productId";
    try {
      await _apiClient.invokeAPI(tendingpath, "DELETE", "");
    } catch (e) {
      throw Exception('Failed to delete : $e');
    }
  }
}
