import '../models/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookings({
    required String id,
  });
}