class ApiOtherReservation {
  final int id;
  final int idWorkPlace;
  final int idEmployee;
  final String timeBegin;
  final String timeEnd;

  ApiOtherReservation.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        idWorkPlace = map['idWorkPlace'],
        idEmployee = map['idEmployee'],
        timeBegin = map['timeBegin'],
        timeEnd = map['timeEnd'];
}