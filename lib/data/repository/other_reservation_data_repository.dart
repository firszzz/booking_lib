

import 'package:atb_flutter_demo/domain/models/other_reservation.dart';
import 'package:atb_flutter_demo/domain/repository/other_reservation_repository.dart';

import '../api/api_util.dart';

class OtherReservationDataRepository extends OtherReservationRepository {
  final ApiUtil _apiUtil;

  OtherReservationDataRepository(this._apiUtil);

  @override
  Future<List<OtherReservation>> getReservations({required String id}) {
    return _apiUtil.getOtherReservations(id: id);
  }
}