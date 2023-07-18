class ApiBooking {
  final int id;
  final int idWorkPlace;
  final int idEmployee;
  final String timeBegin;
  final String timeEnd;

  ApiBooking.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        idEmployee = map['idEmployee'],
        idWorkPlace = map['idWorkPlace'],
        timeBegin = map['timeBegin'],
        timeEnd = map['timeEnd'];
}