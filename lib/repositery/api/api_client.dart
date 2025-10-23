import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:modern_grocery/main.dart';
import 'package:modern_grocery/repositery/api/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<http.Response> invokeAPI(String path, String method,
      [Object? body]) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final String url = basePath + (path.startsWith('/') ? path : '/$path');

    if (kDebugMode) print(' API Request: $method $url');

    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) print(' Token: ${token ?? "No token"}');

    String? encodedBody;
    if (body != null) {
      encodedBody = body is String ? body : jsonEncode(body);
      if (kDebugMode) print(' Body: $encodedBody');
    }

    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case "POST":
          response = await http.post(Uri.parse(url),
              headers: headers, body: encodedBody);
          break;
        case "PUT":
          response = await http.put(Uri.parse(url),
              headers: headers, body: encodedBody);
          break;
        case "DELETE":
          response = await http.delete(Uri.parse(url),
              headers: headers, body: encodedBody);
          break;
        case "PATCH":
          response = await http.patch(Uri.parse(url),
              headers: headers, body: encodedBody);
          break;
        default:
          response = await http.get(Uri.parse(url), headers: headers);
      }
    } catch (e) {
      if (kDebugMode) print(' Network error on $path: $e');
      throw ApiException('Network error: $e', 0);
    }

    if (kDebugMode) {
      print('📡 Status: ${response.statusCode}');
      print('🧾 Response: ${response.body}');
    }

  
    if (response.statusCode >= 400) {
      log('$path : ${response.statusCode} : ${response.body}');
      throw ApiException(_decodeError(response), response.statusCode);
    }

    return response;
  }

  String _decodeError(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      return decoded['message']?.toString() ?? response.body;
    } catch (_) {
      return response.body;
    }
  }
}
