import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:modern_grocery/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_grocery/repositery/model/Banner/CreateBanner_model.dart';

class CreatebannerApi {
  Future<CreateBannerModel> uploadBanner({
    required String title,
    required String category,
    required String type,
    required String categoryId,
    required String link,
    required String imagePath,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    final file = File(imagePath);
    if (!file.existsSync()) {
      throw Exception('Image file not found at path: $imagePath');
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final role = prefs.getString('role');
    print('Stored token: $token');
    print('User role: $role');

    if (token == null || token.isEmpty) {
      throw Exception('Access token not found. Please log in again.');
    }
    if (role != 'adimin') {
      throw Exception('Unauthorized: Only admins can create banners.');
    }

    final uri = Uri.parse('$basePath/banner/create');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields.addAll({
      'title': title,
      'category': category,
      'type': type,
      'categoryId': categoryId,
      'link': link,
    });
    print('Form fields: ${request.fields}');

    final fileName = file.path.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();
    final contentType = MediaType('image', extension == 'png' ? 'png' : 'jpeg');

    // --- Start of Custom Upload Progress Logic ---
    // Read the file as a stream
    final fileStream = file.openRead();
    final totalLength = await file.length();

    int bytesSent = 0;

    // Create a new Stream that wraps the file stream and reports progress
    final progressStream = StreamTransformer<List<int>, List<int>>.fromHandlers(
      handleData: (data, sink) {
        bytesSent += data.length;
        onSendProgress?.call(bytesSent, totalLength);
        sink.add(data);
      },
    ).bind(fileStream);

    final multipartFile = http.MultipartFile(
      'image',
      progressStream,
      totalLength,
      filename: fileName,
      contentType: contentType,
    );

    request.files.add(multipartFile);

    // Send the request
    final streamedResponse = await request.send();

    // Now, listen to the actual response stream from the server
    final response = await http.Response.fromStream(streamedResponse);
    print("📦 Response: ${response.statusCode} => ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CreateBannerModel.fromJson(jsonData);
    } else {
      throw Exception(
          'Upload failed with status ${response.statusCode}: ${response.body}');
    }
  }
}
