import 'dart:convert';

import 'package:atb_flutter_demo/resources/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  Dio api = Dio();
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  Api() {
    api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = AppUrls.baseUrl + options.path;
      }

      accessToken ??= await _storage.read(key: 'accessToken');
      // var login = await _storage.read(key: 'login');
      // var password = await _storage.read(key: 'password');
      // String basicAuth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';
      // options.headers['Authorization'] = basicAuth;
      // print(accessToken);
      // print(await _storage.read(key: 'refreshToken'));
      options.headers['Authorization'] = 'Bearer $accessToken';

      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if (error.response?.statusCode == 403) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          await refreshToken();
          return handler.resolve(await _retry(error.requestOptions));
        }
      } else {
        return handler.resolve(error.response!);
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api.post(
      '/auth/access-token',
      data: {
        'refreshToken': refreshToken,
      }
    );

    if (response.statusCode == 200) {
      accessToken = response.data['accessToken'];
    } else {
      accessToken = null;
      _storage.deleteAll();
    }
  }
}