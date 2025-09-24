import 'dart:convert';
import 'package:http/http.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';

class AddcartApi {
  final ApiClient apiClient;

  AddcartApi({required this.apiClient});

  Future<void> addToCart(String productId, int quantity) async {
    const String path = '/cart/user/addToCart'; // Use the correct endpoint from the error log
    if (productId.isEmpty || productId.length != 24) {
      throw Exception('Invalid product ID');
    }

    final Map<String, dynamic> body = {
      'productId': productId, // Ensure this matches the API's expected field name
      'quantity': quantity,
    };

    try {
      Response response = await apiClient.invokeAPI(path, 'POST', body);
      if (response.statusCode != 200) {
        final errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to add to cart');
      }
    } catch (e) {
      throw Exception('API call failed: $e');
    }
  }

  getAddCartModel(String productId, int quantity) {}
}