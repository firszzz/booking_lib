

import '../../domain/models/approve_reservation.dart';
import '../../domain/repository/approve_reservation_repository.dart';
import '../api/api_util.dart';

class ApproveReservationDataRepository extends ApproveReservationRepository {
  final ApiUtil _apiUtil;

  ApproveReservationDataRepository(this._apiUtil);

  @override
  Future<List<ApproveReservation>> getApproveReservations({required String city}) {
    return _apiUtil.getApproveReservations(city: city);
  }

  @override
  Future<void> deleteApproveReservations({required String id}) {
    return _apiUtil.deleteReservations(id: id);
  }

  @override
  Future<void> confirmApproveReservations({required String id}) {
    return _apiUtil.confirmApproveReservations(id: id);
  }
}