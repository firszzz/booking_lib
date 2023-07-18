import 'package:atb_flutter_demo/data/api/model/api_workplace.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../request/api.dart';

class WorkplaceService {
  final _dio = Api();

  Future<List<ApiWorkplace>> getWorkplacesByTypeLevel({
    required bool type,
    required int floorId,
    required String sortBy,
  }) async {
    final response = await _dio.api.get(
      '/workplaces/find-by-type-level?type=$type&floorId=$floorId&page=0&size=100&sort=$sortBy',
    );
    List<ApiWorkplace> listWorkplaces = [];
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      for (int i = 0; i < data.length; i++) {
        listWorkplaces.add(ApiWorkplace.fromApi(data[i]));
      }

      return listWorkplaces;
    } else {
      return listWorkplaces;
    }
  }

  Future<void> postWorkplace({
    required bool type,
    required int seatsCount,
    required int floorId,
    required String info,
  }) async {
    await _dio.api.post(
      '/workplaces/',
      data: {
        "type": type,
        "seatsCount": seatsCount,
        "info": info,
        "floorId": floorId,
      }
    );
  }

  Future<void> deleteWorkplace({
    required int id,
  }) async {
    final request = await _dio.api.delete(
      '/workplaces/$id',
    );
    return request.data;
  }
}