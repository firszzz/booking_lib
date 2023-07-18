import 'package:atb_flutter_demo/data/api/model/api_approve_reservation.dart';
import 'package:dio/dio.dart';

import '../../../resources/env.dart';
import '../request/api.dart';

class ApproveReservationsService {
  final Dio _dio = Api().api;

  Future<List<ApiApproveReservation>> getApproveReservations({
    required String city,
  }) async {

    final response = await _dio.get(
        '/queue-reservation/find-current-reservations-by-city?city=$city&confirmed=false',
        queryParameters: {
          'pageable': {
            "page": 0,
            "size": 100,
            "sort": [
              "timeBegin"
            ]
          }
        },
    );
    List<ApiApproveReservation> listApproveReservations = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      for (int i = 0; i < data['content'].length; i++) {
        listApproveReservations.add(ApiApproveReservation.fromApi(data['content'][i]));
      }
      return listApproveReservations;
    } else {
      return listApproveReservations;
    }

  }

  Future<void> deleteReservations({
    required String id,
  }) async {

    final request = await _dio.delete(
      '${AppUrls.deleteReservations}$id',
    );
    return request.data;
  }

  Future<void> confirmApproveReservations({
    required String id,
  }) async {
    final request = await _dio.put(
      '/queue-reservation/update-admin-permission',
      data: {
        "id": id,
        "adminPermission": true
      },
    );

    print(request.statusCode);

    return request.data;
  }
}