part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoadingState extends BookingState {
  @override
  List<Object?> get props => [];
}

class BookingLoadedState extends BookingState {
  final List<DateTimeRange> timeList;
  final List<String> officeTimeBegin;
  final List<String> officeTimeEnd;
  final int lastDayBooking;
  final int numSeats;
  final bool hideNumSeats;
  final String workplace;
  int serviceDuration;

  BookingLoadedState(
      {
        required this.timeList,
        required this.officeTimeBegin,
        required this.officeTimeEnd,
        required this.lastDayBooking,
        required this.numSeats,
        required this.workplace,
        required this.hideNumSeats,
        required this.serviceDuration,
      });

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    return timeList;
  }

  Future<dynamic> setReservation({required BookingService newBooking}) async {
    const storage = FlutterSecureStorage();
    final Dio dio = Api().api;
    var login = await storage.read(key: 'login');
    var password = await storage.read(key: 'password');
    var idEmployee = await storage.read(key: 'idEmployee');
    var idWorkPlace = await storage.read(key: 'idWorkPlace');
    var placeType = await storage.read(key: 'placeType');
    bool type = placeType!.toLowerCase() == 'true';

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$login:$password'))}';

    try {
      if (newBooking.bookingEnd.hour == 0) {
        String lateBooking = '${DateFormat('yyyy-MM-dd').format(newBooking.bookingStart)} 23:59';

        var response = await dio.post(
          AppUrls.bookingState,
          data: jsonEncode(<String, dynamic>{
            "timeBegin": "${DateFormat('yyyy-MM-dd').format(newBooking.bookingStart).toString()} ${DateFormat.Hm().format(newBooking.bookingStart).toString()}",
            "timeEnd": lateBooking,
            "adminPermission": !type,
            "idEmployee": int.parse(idEmployee!),
            "idWorkPlace": int.parse(idWorkPlace!),
            "description": type ? "Количество сотрудников/гостей: ${newBooking.numSeats}" : "Количество сотрудников/гостей: 1",
          }),
        );
        /*var response = await http.post(
          Uri.parse(AppUrls.bookingState),
          headers: <String, String>{
            'Authorization': basicAuth,
            "content-type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            "timeBegin": "${DateFormat('yyyy-MM-dd').format(newBooking.bookingStart).toString()} ${DateFormat.Hm().format(newBooking.bookingStart).toString()}",
            "timeEnd": lateBooking,
            "adminPermission": !type,
            "idEmployee": int.parse(idEmployee!),
            "idWorkPlace": int.parse(idWorkPlace!),
            "description": type ? "Количество сотрудников/гостей: ${newBooking.numSeats}" : "Количество сотрудников/гостей: 1",
          }),
        );*/

        if (response.statusCode == 201) {
          timeList.add(DateTimeRange(
              start: newBooking.bookingStart, end: newBooking.bookingEnd));
        }
      }
      else {
        var tb = "${DateFormat('yyyy-MM-dd').format(newBooking.bookingStart).toString()} ${DateFormat.Hm().format(newBooking.bookingStart).toString()}";
        var te = "${DateFormat('yyyy-MM-dd').format(newBooking.bookingEnd).toString()} ${DateFormat.Hm().format(newBooking.bookingEnd).toString()}";


        var response = await dio.post(
            AppUrls.bookingState,
          data: jsonEncode(<String, dynamic>{
            "timeBegin": tb,
            "timeEnd": te,
            "adminPermission": !type,
            "idEmployee": int.parse(idEmployee!),
            "idWorkPlace": int.parse(idWorkPlace!),
            "description": type ? "Количество сотрудников/гостей: ${newBooking.numSeats}" : "Количество сотрудников/гостей: 1"
          }),
        );
        /*var response = await http.post(
          Uri.parse(AppUrls.bookingState),
          headers: <String, String>{
            'Authorization': basicAuth,
            "content-type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            "timeBegin": tb,
            "timeEnd": te,
            "adminPermission": !type,
            "idEmployee": int.parse(idEmployee!),
            "idWorkPlace": int.parse(idWorkPlace!),
            "description": type ? "Количество сотрудников/гостей: ${newBooking.numSeats}" : "Количество сотрудников/гостей: 1"
          }),
        );*/

        if (response.statusCode == 201) {
          timeList.add(DateTimeRange(
              start: newBooking.bookingStart, end: newBooking.bookingEnd));
        }
      }
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }

  List<DateTimeRange> generatePauseSlots() {
    final now = DateTime.now();
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 0, 0),
          end: DateTime(now.year, now.month, now.day, now.hour, now.minute)
      )
    ];
  }

  Stream<dynamic>? getBookingStream(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  List<Object?> get props => [timeList];
}

class BookingEmptyState extends BookingState {

}

class BookingErrorState extends BookingState {
  BookingErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
