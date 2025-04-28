import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:modern_grocery/main.dart';
import 'package:modern_grocery/repositery/api/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<http.Response> invokeAPI(
      String path, String method, Object? body) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('Token');
    // final BizUserId = preferences.getString('UserId');

    String url = basePath + path;
    if (kDebugMode) {
      print(url);
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
    Map<String, String> Bizheaders = {
      'Content-Type': 'application/json',
      // 'authorization': 'Bearer $BizToken',
    };

    http.Response response;

    switch (method) {
      case "POST":
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case "PUT":
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await http.delete(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case "GET":
        // Handling GET with body
        final request = http.Request(
          'GET',
          Uri.parse(url),
        );
        request.headers.addAll(headers);

        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        break;
      case "BIZGET":
        // Handling GET with body
        final request = http.Request(
          'GET',
          Uri.parse(url),
        );
        request.headers.addAll(Bizheaders);

        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        break;
      case "PATCH":
        response = await http.patch(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      default:
        response = await http.get(Uri.parse(url), headers: headers);
    }

    if (kDebugMode) {
      print('status of $path => ${response.statusCode}');
    }
    if (kDebugMode) {
      print(response.body);
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
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
