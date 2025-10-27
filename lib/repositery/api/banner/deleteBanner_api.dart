import 'package:modern_grocery/repositery/api/api_client.dart';

class DeletebannerApi {
  ApiClient apiClient = ApiClient();

  Future<void> detetebanner(String bannerId) async {
    String trendingPath = "/banner/delete/$bannerId";

    try {
      await apiClient.invokeAPI(trendingPath, "DELETE");
    } catch (e) {
      throw Exception("Failed to DELETE:$e");
    }
  }
}
