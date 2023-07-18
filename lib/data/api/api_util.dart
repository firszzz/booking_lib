import 'package:atb_flutter_demo/data/api/request/get_user_body.dart';
import 'package:atb_flutter_demo/data/api/service/approve_reservations_service.dart';
import 'package:atb_flutter_demo/data/api/service/floor_service.dart';
import 'package:atb_flutter_demo/data/api/service/office_service.dart';
import 'package:atb_flutter_demo/data/api/service/booking_service.dart';
import 'package:atb_flutter_demo/data/api/service/other_reservation_service.dart';
import 'package:atb_flutter_demo/data/api/service/reservation_service.dart';
import 'package:atb_flutter_demo/data/api/service/statistic_service.dart';
import 'package:atb_flutter_demo/data/api/service/support_service.dart';
import 'package:atb_flutter_demo/data/api/service/user_service.dart';
import 'package:atb_flutter_demo/data/api/service/workplace_service.dart';
import 'package:atb_flutter_demo/data/mapper/approve_reservation_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/floor_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/office_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/booking_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/other_reservation_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/reservation_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/statistic_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/support_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/user_mapper.dart';
import 'package:atb_flutter_demo/data/mapper/workplace_mapper.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:atb_flutter_demo/domain/models/other_reservation.dart';
import 'package:atb_flutter_demo/domain/models/reservation.dart';
import 'package:atb_flutter_demo/domain/models/statistic.dart';
import 'package:atb_flutter_demo/domain/models/support_message.dart';
import 'package:atb_flutter_demo/domain/models/workplace.dart';

import '../../domain/models/approve_reservation.dart';
import '../../domain/models/booking.dart';
import '../../domain/models/user.dart';

class ApiUtil {
  final UserService _userService;
  final ReservationService _reservationService;
  final WorkplaceService _workplaceService;
  final OfficeService _officeService;
  final BookingService _bookingService;
  final SupportService _supportService;
  final OtherReservationService _otherReservationService;
  final StatisticService _statisticService;
  final FloorService _floorService;
  final ApproveReservationsService _approveReservationsService;

  ApiUtil(
      this._userService,
      this._reservationService,
      this._workplaceService,
      this._officeService,
      this._bookingService,
      this._supportService,
      this._otherReservationService,
      this._statisticService,
      this._floorService,
      this._approveReservationsService,
      );


  /// User service
  Future<User> getUser({
    required String id,
  }) async {
    final result = await _userService.getUser(id: id);
    return UserMapper.fromApi(result);
  }

  Future<List<User>> getAllUsers() async {
    final result = await _userService.getAllUsers();
    List<User> employees = [];
    for (int i = 0; i < result.length; i++) {
      employees.add(UserMapper.fromApi(result[i]));
    }
    return employees;
  }


  /// Statistic service
  Future<List<Statistic>> getStatistic({
    required int officeId,
    required timeBegin,
    required timeEnd,
  }) async {
    var result = await _statisticService.getStatistic(
        officeId: officeId, timeBegin: timeBegin, timeEnd: timeEnd);

    List<Statistic> listStatistic = [];

    for (int i = 0; i < result.length; i++) {
      listStatistic.add(StatisticMapper.fromApi(result[i]));
    }

    return listStatistic;
  }


  /// Reservations service
  Future<List<Reservation>> getReservations({
    required String id,
  }) async {
    var result = await _reservationService.getReservations(id: id);

    List<Reservation> listReservations = [];
    for (int i = 0; i < result.length; i++) {
      listReservations.add(ReservationMapper.fromApi(result[i]));
    }

    /*List<Reservation> sortedReservations = [];
    for (var el in listReservations) {
      if (DateTime.parse("${el.date} ${el.timeEnd}").isAfter(DateTime.now())) {
        sortedReservations.add(el);
      }
    }*/
    return listReservations;
  }

  Future<List<Reservation>> getConfirmedReservations({
    required String id,
    required bool confirmed,
  }) async {
    var data = await _reservationService.getConfirmedReservations(
        id: id, confirmed: confirmed);

    List<Reservation> reservations = [];
    for (int i = 0; i < data.length; i++) {
      reservations.add(ReservationMapper.fromApi(data[i]));
    }

    return reservations;
  }

  Future<List<OtherReservation>> getOtherReservations({
    required String id,
  }) async {
    var result = await _otherReservationService.getReservations(id: id);

    List<OtherReservation> listReservations = [];
    for (int i = 0; i < result.length; i++) {
      listReservations.add(OtherReservationMapper.fromApi(result[i]));
    }

    return listReservations;
  }

  Future<void> deleteReservations({
    required String id,
  }) async {
    var request = await _reservationService.deleteReservations(id: id);
    return request;
  }

  Future<void> confirmApproveReservations({
    required String id,
  }) async {
    var request = await _approveReservationsService.confirmApproveReservations(id: id);
    return request;
  }

  /// ApproveReservations service
  Future<List<ApproveReservation>> getApproveReservations({
    required String city,
  }) async {
    var result = await _approveReservationsService.getApproveReservations(city: city);

    List<ApproveReservation> listApproveReservations = [];

    for (int i = 0; i < result.length; i++) {
      listApproveReservations.add(ApproveReservationMapper.fromApi(result[i]));
    }

    return listApproveReservations;
  }

  /// Booking service
  Future<List<Booking>> getBookings({
    required String id,
  }) async {
    var result = await _bookingService.getBookingsWorkplace(id: id);

    List<Booking> listBookings = [];
    for (var el in result) {
      listBookings.add(BookingMapper.fromApi(el));
    }

    return listBookings;
  }


  /// Support service
  Future<List<SupportMessage>> getSupports({required String status}) async {
    var result = await _supportService.getSupport(status: status);

    List<SupportMessage> listSupports = [];
    for (var el in result) {
      listSupports.add(SupportMapper.fromApi(el));
    }

    return listSupports;
  }

  Future<void> changeStatusSupport(
      {required String id, required String status}) async {
    var request =
        await _supportService.changeStatusSupport(status: status, id: id);
    return request;
  }

  Future<void> sendSupportMessage(
      {required String topic, required String textMessage}) async {
    var request = await _supportService.sendSupportMessage(
        topic: topic, textMessage: textMessage);
    return request;
  }


  /// Workplace service
  Future<List<Workplace>> getWorkplacesByTypeLevel({
    required bool type,
    required int floorId,
    required String sortBy,
  }) async {
    var result = await _workplaceService.getWorkplacesByTypeLevel(
        type: type,
        floorId: floorId,
        sortBy: sortBy,
    );

    List<Workplace> listWorkplaces = [];
    for (int i = 0; i < result.length; i++) {
      listWorkplaces.add(WorkplaceMapper.fromApi(result[i]));
    }
    return listWorkplaces;
  }

  Future<void> postWorkplace({
    required bool type,
    required int seatsCount,
    required int floorId,
    required String info,
  }) async {
    final request = await _workplaceService.postWorkplace(
      type: type,
      seatsCount: seatsCount,
      floorId: floorId,
      info: info,
    );
    return request;
  }

  Future<void> deleteWorkplace({
    required int id,
  }) async {
    return await _workplaceService.deleteWorkplace(id: id);
  }


  /// Office service
  Future<List<int>> getOfficeLevels({
    required String id,
  }) {
    return _officeService.getOfficeLevels(
      id: id,
    );
  }

  Future<List<String>> getCities() {
    return _officeService.getCities();
  }

  Future<List<Office>> getOfficeInfo({
    required String id,
  }) async {
    final result = await _officeService.getOfficeInfo(id: id);

    List<Office> officeInfo = [];
    for (int i = 0; i < result.length; i++) {
      officeInfo.add(OfficeMapper.fromApi(result[i]));
    }
    return officeInfo;
  }

  Future<List<Office>> getOffices({
    required String city,
  }) async {
    final result = await _officeService.getOffices(city: city);

    List<Office> officeList = [];
    for (int i = 0; i < result.length; i++) {
      officeList.add(OfficeMapper.fromApi(result[i]));
    }
    return officeList;
  }

  Future<void> postOffice({
    required String timeBegin,
    required String timeEnd,
    required bool access,
    required String city,
    required int numDay,
    required String address,
    required String timeZone,
  }) async {
    final request = await _officeService.postOffice(
      timeBegin: timeBegin,
      timeEnd: timeEnd,
      access: access,
      city: city,
      numDay: numDay,
      address: address,
      timeZone: timeZone,
    );
    return request;
  }


  /// Floor service
  Future<List<Floor>> getOfficeFloors({
  required int officeId,
  }) async {
    final result = await _floorService.getOfficeFloors(officeId: officeId);

    List<Floor> floors = [];
    for (int i = 0; i < result.length; i++) {
      floors.add(FloorMapper.fromApi(result[i]));
    }

    return floors;
  }

  Future<void> postFloor({
    required int officeId,
    required int floorNumber,
  }) async {
    final request = await _floorService.postFloor(
        officeId: officeId,
        floorNumber: floorNumber,
    );
    return request;
  }

}
