import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:modern_grocery/main.dart';
import 'package:modern_grocery/repositery/api/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<http.Response> invokeAPI(
      String path, String method, Object? body) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    String cleanPath = path.startsWith('/') ? path : '/$path';
    String cleanBasePath = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;
    String url = cleanBasePath + cleanPath;

    if (kDebugMode) print(' $method $url');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    // 🔍 DEBUG: Print body BEFORE encoding
    if (body != null && kDebugMode) {
      print('Body before encoding: $body');
      print(' Body type: ${body.runtimeType}');
      if (body is Map) {
        body.forEach((key, value) {
          print('🔍   $key: $value (${value.runtimeType})');
        });
      }
    }

    // 🔍 DEBUG: Print encoded body
    String? encodedBody;
    if (body != null) {
      encodedBody = jsonEncode(body);
      if (kDebugMode) {
        print(' Encoded body: $encodedBody');
        // Parse it back to verify
        var decoded = jsonDecode(encodedBody);
        print(' Decoded back: $decoded');
        if (decoded is Map) {
          decoded.forEach((key, value) {
            print('🔍   $key: $value (${value.runtimeType})');
          });
        }
      }
    }

    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case "POST":
          response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: encodedBody,
          );
          break;
        case "PUT":
          response = await http.put(
            Uri.parse(url),
            headers: headers,
            body: encodedBody,
          );
          break;
        case "DELETE":
          response = await http.delete(
            Uri.parse(url),
            headers: headers,
            body: encodedBody,
          );
          break;
        case "PATCH":
          response = await http.patch(
            Uri.parse(url),
            headers: headers,
            body: encodedBody,
          );
          break;
        default: // GET
          response = await http.get(Uri.parse(url), headers: headers);
      }
    } catch (e) {
      if (kDebugMode) print(' Network error on $path: $e');
      throw ApiException('Network error: $e', 0);
    }

    if (kDebugMode) {
      print(' status of $path => ${response.statusCode}');
      print(' Response body: ${response.body}');
    }

    if (response.statusCode >= 400) {
      log('$path : ${response.statusCode} : ${response.body}');
      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }

    return response;
  }

  String _decodeBodyBytes(http.Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      try {
        final decoded = jsonDecode(response.body);
        return decoded['message'] ?? response.body;
      } catch (e) {
        return response.body;
      }
    } else {
      return response.body;
    }
  }
}
