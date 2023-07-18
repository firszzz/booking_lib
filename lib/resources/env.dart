abstract class AppUrls {
  // static const String baseUrl = 'http://127.0.0.1:8080';
  static const String baseUrl = 'http://10.0.2.2:8080';

  static const String deleteReservations = '/queue-reservation/';
  static const String user = '/employees/';
  static const String workplacePart1 = '/workplaces/find-by-type-level-office?type=false&numLevel=';
  static const String workplacePart2 = '&idOffice=1&page=0&size=100&sort=id';
  static const String bookingPart1 = '/queue-reservation/find-by-workplace?idWorkPlace=';
  static const String bookingPart2 = '&page=0&size=100&sort=timeBegin';
  static const String bookingState = '/queue-reservation/';
  static const String auth = '/employees/find?login=';
  static const String getCities = '/offices/get-cities?page=0&size=100&sort=city';
  static const String getSupportMessages1 = '/support-messages/find-by-status?statusMessage=';
  static const String getSupportMessages2 = '&page=0&size=100&sort=id';
  static const String changeStatusSupport = '/support-messages/';
}