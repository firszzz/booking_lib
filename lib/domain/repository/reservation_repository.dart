import '../models/reservation.dart';

abstract class ReservationRepository {
  Future<List<Reservation>> getReservations({
    required String id,
  });

  Future<List<Reservation>> getConfirmedReservations({
    required String id,
    required bool confirmed,
  });

  Future<void> deleteReservations({
    required String id,
  });
}
