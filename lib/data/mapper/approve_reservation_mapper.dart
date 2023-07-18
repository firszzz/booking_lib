

import 'package:atb_flutter_demo/data/api/model/api_approve_reservation.dart';
import 'package:atb_flutter_demo/domain/models/approve_reservation.dart';
import 'package:intl/intl.dart';

class ApproveReservationMapper {
  static ApproveReservation fromApi(ApiApproveReservation reservations) {
    var date = DateTime.parse(reservations.timeBegin).toLocal();
    var formattedDate = DateFormat('dd-MM-yyyy').format(date);

    var timeBegin = DateTime.parse(reservations.timeBegin).toLocal();
    var formattedTimeBegin = DateFormat('kk:mm').format(timeBegin);
    var timeEnd = DateTime.parse(reservations.timeEnd).toLocal();
    var formattedTimeEnd = DateFormat('kk:mm').format(timeEnd);

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }
    String calcTimeToStart(int timeToStart) {
      int preLastDigit = timeToStart % 100;
      switch (timeToStart % 10) {
        case 1:
          return "Через $preLastDigit день";
        case 2:
        case 3:
        case 4:
          return "Через $preLastDigit дня";
        default:
          return "Через $preLastDigit дней";
      }
    }

    return ApproveReservation(
      id: reservations.id,
      timeToStart: calcTimeToStart(daysBetween(DateTime.now(), date)),
      idWorkPlace: reservations.idWorkPlace,
      officeLevel: reservations.officeLevel,
      date: formattedDate,
      timeBegin: formattedTimeBegin,
      timeEnd: formattedTimeEnd,
      info: reservations.info,
      adminPermission: reservations.adminPermission,
      isMeetingRoom: reservations.isMeetingRoom,
    );
  }
}