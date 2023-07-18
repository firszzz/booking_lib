import 'package:dio/dio.dart';

import '../../../resources/env.dart';
import '../model/api_booking.dart';
import '../request/api.dart';

class BookingService {
  final Dio _dio = Api().api;

  Future<List<ApiBooking>> getBookingsWorkplace({
    required String id,
  }) async {
    final response = await _dio.get(
        '${AppUrls.bookingPart1}$id${AppUrls.bookingPart2}',
    );
    List<ApiBooking> listBookings = [];

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['content'];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> map = data[i];
        listBookings.add(ApiBooking.fromApi(map));
      }

      return listBookings;
    } else {
      return listBookings;
    }
  }
}