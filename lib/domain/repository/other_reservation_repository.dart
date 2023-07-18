
import 'package:atb_flutter_demo/domain/models/other_reservation.dart';

abstract class OtherReservationRepository {
  Future<List<OtherReservation>> getReservations({
    required String id,
  });
}