import 'package:atb_flutter_demo/data/api/api_util.dart';
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

class ApiModule {
  static ApiUtil apiUtil() {
    ApiUtil apiUtil = ApiUtil(
      UserService(),
      ReservationService(),
      WorkplaceService(),
      OfficeService(),
      BookingService(),
      SupportService(),
      OtherReservationService(),
      StatisticService(),
      FloorService(),
      ApproveReservationsService(),
    );
    return apiUtil;
  }
}
