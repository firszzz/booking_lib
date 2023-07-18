import 'package:atb_flutter_demo/data/api/model/api_other_reservations.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class OtherReservationService {
  final Dio _dio = Api().api;

  Future<List<ApiOtherReservation>> getReservations({
    required String id,
  }) async {
    final response = await _dio.get(
        '/queue-reservation/find-current-reservations-by-employee?idEmployee=$id&page=0&size=100&sort=id',
    );
    List<ApiOtherReservation> listReservations = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      for (int i = 0; i < data['content'].length; i++) {
        listReservations.add(ApiOtherReservation.fromApi(data['content'][i]));
      }
      return listReservations;
    } else {
      return listReservations;
    }

  }
}