import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_grocery/repositery/model/CreateBanner_model.dart';

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

    // 🔑 Retrieve token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    if (token == null || token.isEmpty) {
      throw Exception('Access token not found. Please log in again.');
    }

    final uri = Uri.parse(
        'https://modern-store-backend.onrender.com/api/banner/create');
    final request = http.MultipartRequest('POST', uri);

    // 🔐 Set authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // 📄 Add form fields
    request.fields.addAll({
      'title': title,
      'category': category,
      'type': type,
      'categoryId': categoryId,
      'link': link,
    });

    // 📷 Add image file
    final fileName = file.path.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();
    final contentType = MediaType('image', extension == 'png' ? 'png' : 'jpeg');

    final multipartFile = await http.MultipartFile.fromPath(
      'images',
      file.path,
      filename: fileName,
      contentType: contentType,
    );

    request.files.add(multipartFile);

    final streamedResponse = await request.send();

    // 📦 Optional upload progress callback
    if (onSendProgress != null) {
      final total = file.lengthSync();
      int sent = 0;
      streamedResponse.stream.listen(
        (chunk) {
          sent += chunk.length;
          onSendProgress(sent, total);
        },
        onError: (e) => throw Exception("Upload stream error: $e"),
        cancelOnError: true,
      );
    }

    // 🧾 Read and decode response
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CreateBannerModel.fromJson(jsonData);
    } else {
      throw Exception(
          'Upload failed with status ${response.statusCode}: ${response.body}');
    }
  }
}
