import 'package:atb_flutter_demo/data/api/model/api_floor.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class FloorService {
  final Dio _dio = Api().api;

  Future<List<ApiFloor>> getOfficeFloors({
    required int officeId,
  }) async {
    final response = await _dio.get(
      '/floors/get-office-floors?id=$officeId&page=0&size=100&sort=floorNumber',
    );
    List<ApiFloor> apiFloors = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      for (int i = 0; i < data['content'].length; i++) {
        apiFloors.add(ApiFloor.fromApi(data['content'][i]));
      }

      return apiFloors;
    } else {
      return apiFloors;
    }

  }

  Future<void> postFloor({
    required int officeId,
    required int floorNumber,
  }) async {
    await _dio.post(
        '/floors',
        data: {
          "idOffice": officeId,
          "floorNumber": floorNumber,
        }
    );

  }

}
