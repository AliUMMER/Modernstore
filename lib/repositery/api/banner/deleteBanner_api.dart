import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeletebannerApi {
  ApiClient apiClient = ApiClient();

  Future<void> deletebanner(String bannerId) async {
    String trendingPath = "/banner/delete/$bannerId";

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception("Authentication Error: Token not found.");
      }
      final Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      await apiClient.invokeAPI(trendingPath, "DELETE", headers);
    } catch (e) {
      throw Exception("Failed to DELETE:$e");
    }
  }
}
