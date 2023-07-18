class ApiStatistic {
  final int idWorkplace;
  final int countReservations;

  ApiStatistic.fromApi(Map<String, dynamic> map)
      : idWorkplace = map['idWorkplace'],
        countReservations = map['countReservations'];
}