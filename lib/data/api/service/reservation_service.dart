import 'package:atb_flutter_demo/data/api/model/api_reservation.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class ReservationService {
  final Dio _dio = Api().api;

  Future<List<ApiReservation>> getReservations({
    required String id,
  }) async {
    final response = await _dio.get(
        '/queue-reservation/find-by-employee?idEmployee=$id&page=0&size=100&sort=timeBegin',
    );

    List<ApiReservation> listReservations = [];
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      for (int i = 0; i < data['content'].length; i++) {
        listReservations.add(ApiReservation.fromApi(data['content'][i]));
      }
      return listReservations;
    } else {
      return listReservations;
    }

  }

  Future<List<ApiReservation>> getConfirmedReservations({
    required String id,
    required bool confirmed,
  }) async {
    final response = await _dio.get(
        '/queue-reservation/find-current-reservations-by-employee?idEmployee=$id&confirmed=$confirmed&page=0&size=100&sort=timeBegin',
    );
    List<ApiReservation> apiReservations = [];

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      for (int i = 0; i < data['content'].length; i++) {
        apiReservations.add(ApiReservation.fromApi(data['content'][i]));
      }

      return apiReservations;
    } else {
      return apiReservations;
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
}