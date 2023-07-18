import 'package:atb_flutter_demo/data/api/model/api_other_reservations.dart';
import 'package:atb_flutter_demo/data/api/model/api_reservation.dart';
import 'package:atb_flutter_demo/domain/models/other_reservation.dart';
import 'package:atb_flutter_demo/domain/models/reservation.dart';

class OtherReservationMapper {
  static OtherReservation fromApi(ApiOtherReservation reservation) {
    return OtherReservation(
      id: reservation.id,
      idWorkPlace: reservation.idWorkPlace,
      timeBegin: reservation.timeBegin,
      timeEnd: reservation.timeEnd,
      idEmployee: reservation.idEmployee
    );
  }
}