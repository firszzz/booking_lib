class ApiOffice {
  final int id;
  final String timeBegin;
  final String timeEnd;
  final bool access;
  final String city;
  final int numDay;
  final String address;
  final String timeZone;

  ApiOffice.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        timeBegin = map['timeBegin'],
        timeEnd = map['timeEnd'],
        access = map['access'],
        city = map['city'],
        numDay = map['numDay'],
        address = map['address'],
        timeZone = map['timeZone'];
}
