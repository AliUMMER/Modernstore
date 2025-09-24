import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateProductApi {
  Future<void> uploadProduct({
    required String productName,
    required String categoryId,
    required String productDescription,
    required String productDetails,
    required String basePrice,
    required String discountPercentage,
    required String unit,
    required File imageFile,
  }) async {
    final url = Uri.parse('http://69.62.79.175:4735/api/product/create');
    final request = http.MultipartRequest('POST', url);

    // Load auth token
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('Token');

    if (token == null) {
      throw Exception('🔒 Authentication token is missing.');
    }

    // Set auth header
    request.headers['Authorization'] = 'Bearer $token';

    // Set form fields
    request.fields['name'] = productName;
    request.fields['basePrice'] = basePrice;
    request.fields['discountPercentage'] = discountPercentage;
    request.fields['unit'] = unit;
    request.fields['description'] = productDescription;
    request.fields['details'] = 'Default description';
    request.fields['categoryId'] = categoryId;

    // Attach image
    request.files
        .add(await http.MultipartFile.fromPath('images', imageFile.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('✅ Status: ${response.statusCode}');
      print('📦 Response: $responseBody');

      final data = json.decode(responseBody);
      if (response.statusCode == 200) {
        print('🎉 Product Created: ${data['data'] ?? 'No data returned'}');
      } else if (response.statusCode == 201) {
        print('🎉 Product Created: ${data['data'] ?? 'No data returned'}');
      } else {
        throw Exception('❌ Failed: ${data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('🚨 Error uploading product: $e');
      throw Exception('Error uploading product: $e');
    }
  }
}
