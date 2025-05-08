import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/model/createCategory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatecategoryApi {
  final ApiClient apiClient;

  CreatecategoryApi({required this.apiClient});

  /// Creates a new category by sending a POST request with category name, description, and image file.
  /// Returns a [CreateCategoryModel] if successful, or throws an exception on failure.
  Future<CreateCategoryModel> createCategory({
    required String categoryName,
    required File imageFile,
    String description = 'Default description',
  }) async {
    const String path = 'http://192.168.1.56:4055/api/category/create';
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('Token');

    // Validate inputs
    if (categoryName.isEmpty) {
      throw Exception('Category name cannot be empty');
    }
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }
    if (!imageFile.existsSync()) {
      throw Exception('Image file does not exist');
    }

    // Log inputs
    print('Category Name: $categoryName');
    print('Description: $description');
    print(
        'Image Path: ${imageFile.path}, Size: ${await imageFile.length()} bytes');
    print('Token: ${token.substring(0, 10)}...');

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(path))
      ..fields['name'] = categoryName
      ..fields['description'] = description
      ..headers.addAll({
        'authorization': 'Bearer $token',
      });

    // Add the image file
    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Response JSON: $jsonResponse');
        if (jsonResponse['success'] == true) {
          return CreateCategoryModel.fromJson(
            jsonResponse['category'] as Map<String, dynamic>,
          );
        } else {
          throw Exception(
              'API returned success: false - ${jsonResponse['message'] ?? 'Unknown error'}');
        }
      } else {
        switch (response.statusCode) {
          case 400:
            throw Exception(
                'Bad request: Invalid category data - ${response.body}');
          case 401:
            throw Exception('Unauthorized: Authentication required');
          case 403:
            throw Exception('Forbidden: Insufficient permissions');
          case 500:
            throw Exception('Server error: Please try again later');
          default:
            throw Exception(
                'Failed to create category: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }
}
