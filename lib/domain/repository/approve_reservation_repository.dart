

import 'package:atb_flutter_demo/domain/models/approve_reservation.dart';

abstract class ApproveReservationRepository {
  Future<List<ApproveReservation>> getApproveReservations({
    required String city,
  });

  Future<void> deleteApproveReservations({
    required String id,
  });

  Future<void> confirmApproveReservations({
    required String id,
  });
}