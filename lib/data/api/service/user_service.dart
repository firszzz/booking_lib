import 'package:atb_flutter_demo/resources/env.dart';

import '../model/api_user.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class UserService {
  final Dio _dio = Api().api;

  Future<ApiUser> getUser({
    required String id,
  }) async {
    final response = await _dio.get(
      '${AppUrls.user}$id',
    );

    return ApiUser.fromApi(response.data);
  }

  Future<List<ApiUser>> getAllUsers() async {
    final response = await _dio.get(
      '/employees/find-all?page=0&size=15&sort=id',
    );

    final Map<String, dynamic> data = response.data;
    List<ApiUser> apiEmployees = [];
    for (int i = 0; i < data['content'].length; i++) {
      apiEmployees.add(ApiUser.fromApi(data['content'][i]));
    }
    return apiEmployees;
  }
}


