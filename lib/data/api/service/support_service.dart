import 'package:atb_flutter_demo/data/api/model/api_support.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../resources/env.dart';
import '../request/api.dart';

class SupportService {
  final Dio _dio = Api().api;

  Future<List<ApiSupport>> getSupport({
    required String status
  }) async {
    final response = await _dio.get(
        '${AppUrls.getSupportMessages1}$status${AppUrls.getSupportMessages2}',
    );
    List<ApiSupport> listSupports = [];

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> map = data[i];
        listSupports.add(ApiSupport.fromApi(map));
      }

      return listSupports;
    } else {
      return listSupports;
    }
  }

  Future<void> changeStatusSupport({
    required String status,
    required String id
  }) async {
    await _dio.patch(
      '${AppUrls.changeStatusSupport}$id/status',
      data: {
        "statusMessage": status
      },
    );
  }

  Future<void> sendSupportMessage({
    required String topic,
    required String textMessage
  }) async {
    const storage = FlutterSecureStorage();
    var idEmployee = await storage.read(key: 'idEmployee');

    await _dio.post(
        AppUrls.changeStatusSupport,
        data: {
          "topic": topic,
          "textMessage": textMessage,
          "employeeId": int.parse(idEmployee!)
        },
    );
  }
}