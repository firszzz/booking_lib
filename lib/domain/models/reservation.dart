class Reservation {
  final int id;
  final String timeToStart;
  final int idWorkPlace;
  final int officeLevel;
  final String date;
  final String timeBegin;
  final String timeEnd;
  final String info;
  final bool adminPermission;
  final bool isMeetingRoom;
  final String reservationDescription;

  Reservation({
    required this.id,
    required this.timeToStart,
    required this.idWorkPlace,
    required this.officeLevel,
    required this.date,
    required this.timeBegin,
    required this.timeEnd,
    required this.info,
    required this.adminPermission,
    required this.isMeetingRoom,
    required this.reservationDescription,
  });
}
