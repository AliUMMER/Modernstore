import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatecategoryApi {
  final ApiClient apiClient;

  CreatecategoryApi({required this.apiClient});

  Future<void> uploadCategory({
    required String categoryName,
    required File imageFile,
  }) async {
    final url = Uri.parse('https/api/category/create');
    final request = http.MultipartRequest('POST', url);

    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    print('Stored token: $token');

    if (token == null) {
      throw Exception('Token is missing. User is not authenticated.');
    }

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = categoryName;
    request.fields['description'] = 'Default description';

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));

    try {
      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      print(' Response Status: ${response.statusCode}');
      print(' Response Body: $resBody');

      if (response.statusCode == 200) {
        final data = json.decode(resBody);
        print(' Category Created: ${data['data'] ?? 'No data returned'}');
      } else {
        final errorResponse = json.decode(resBody);
        throw Exception(
            ' Failed to create category: ${errorResponse['message']}');
      }
    } catch (e) {
      print(' Error during upload: $e');
      throw Exception('Error while uploading category: $e');
    }
  }
}
