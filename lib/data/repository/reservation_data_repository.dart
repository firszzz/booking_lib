import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/reservation.dart';
import 'package:atb_flutter_demo/domain/repository/reservation_repository.dart';

import '../api/model/api_reservation.dart';

class ReservationDataRepository extends ReservationRepository{
  final ApiUtil _apiUtil;

  ReservationDataRepository(this._apiUtil);

  @override
  Future<List<Reservation>> getReservations({required String id}) {
    return _apiUtil.getReservations(id: id);
  }

  @override
  Future<List<Reservation>> getConfirmedReservations({
    required String id,
    required bool confirmed,
  }) {
    return _apiUtil.getConfirmedReservations(
        id: id,
        confirmed: confirmed,
    );
  }

  @override
  Future<void> deleteReservations({required String id}) {
    return _apiUtil.deleteReservations(id: id);
  }

}
