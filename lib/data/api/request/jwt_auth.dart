import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../resources/env.dart';

class JwtAuthController {
  static const String baseUrl = AppUrls.baseUrl;

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response?> auth({
    required String login,
    required String password,
  }) async {
    const storage = FlutterSecureStorage();
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';

    try {
      final response = await _dio.post(
        '/auth/login',
        options: Options(headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json',
        }),
        data: {"identification": login, "password": password},
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
