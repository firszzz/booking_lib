class ApiApproveReservation {
  final int id;
  final int idWorkPlace;
  final int officeLevel;
  final String info;
  final String timeBegin;
  final String timeEnd;
  final bool adminPermission;
  final bool isMeetingRoom;

  ApiApproveReservation.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        idWorkPlace = map['idWorkPlace'],
        officeLevel = map['officeLevel'],
        info = map['workPlaceInfo'],
        timeBegin = map['timeBegin'],
        timeEnd = map['timeEnd'],
        adminPermission = map['adminPermission'],
        isMeetingRoom = map['isMeetingRoom'];
}