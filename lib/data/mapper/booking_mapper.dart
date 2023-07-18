

import 'package:atb_flutter_demo/data/api/model/api_booking.dart';
import 'package:atb_flutter_demo/domain/models/booking.dart';

class BookingMapper {
  static Booking fromApi(ApiBooking bookings) {
    return Booking(
      id: bookings.id,
      idEmployee: bookings.idEmployee,
      idWorkPlace: bookings.idWorkPlace,
      timeBegin: bookings.timeBegin,
      timeEnd: bookings.timeEnd,
    );
  }
}