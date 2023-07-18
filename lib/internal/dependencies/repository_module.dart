import 'package:atb_flutter_demo/data/api/service/other_reservation_service.dart';
import 'package:atb_flutter_demo/data/repository/approve_reservations_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/booking_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/floor_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/office_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/reservation_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/support_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/user_data_repository.dart';
import 'package:atb_flutter_demo/data/repository/workplace_data_repository.dart';
import 'package:atb_flutter_demo/domain/repository/approve_reservation_repository.dart';
import 'package:atb_flutter_demo/domain/repository/booking_repository.dart';
import 'package:atb_flutter_demo/domain/repository/floor_repository.dart';
import 'package:atb_flutter_demo/domain/repository/office_repository.dart';
import 'package:atb_flutter_demo/domain/repository/other_reservation_repository.dart';
import 'package:atb_flutter_demo/domain/repository/reservation_repository.dart';
import 'package:atb_flutter_demo/domain/repository/support_repository.dart';
import 'package:atb_flutter_demo/domain/repository/user_repository.dart';
import 'package:atb_flutter_demo/domain/repository/workplace_repository.dart';

import '../../data/repository/other_reservation_data_repository.dart';
import '../../data/repository/statistic_data_repository.dart';
import '../../domain/repository/statistic_repository.dart';
import '/internal/dependencies/api_module.dart';


class RepositoryModule {
  static UserRepository userRepository() {
    UserRepository userRepository = UserDataRepository(ApiModule.apiUtil());
    return userRepository;
  }
  static ReservationRepository reservationRepository() {
    ReservationRepository reservationRepository = ReservationDataRepository(ApiModule.apiUtil());
    return reservationRepository;
  }
  static WorkplaceRepository workplaceRepository() {
    WorkplaceRepository workplaceRepository = WorkplaceDataRepository(ApiModule.apiUtil());
    return workplaceRepository;
  }
  static OfficeRepository officeRepository() {
    OfficeRepository officeRepository = OfficeDataRepository(ApiModule.apiUtil());
    return officeRepository;
  }
  static BookingRepository bookingRepository() {
    BookingRepository bookingRepository = BookingDataRepository(ApiModule.apiUtil());
    return bookingRepository;
  }
  static SupportRepository supportRepository() {
    SupportRepository supportRepository = SupportDataRepository(ApiModule.apiUtil());
    return supportRepository;
  }
  static OtherReservationRepository otherReservationRepository() {
    OtherReservationRepository otherReservationRepository = OtherReservationDataRepository(ApiModule.apiUtil());
    return otherReservationRepository;
  }
  static StatisticRepository statisticRepository() {
    StatisticRepository statisticRepository = StatisticDataRepository(ApiModule.apiUtil());
    return statisticRepository;
  }
  static FloorRepository floorRepository() {
    FloorRepository floorRepository = FloorDataRepository(ApiModule.apiUtil());
    return floorRepository;
  }
  static ApproveReservationRepository approveReservationRepository() {
    ApproveReservationRepository approveReservationRepository = ApproveReservationDataRepository(ApiModule.apiUtil());
    return approveReservationRepository;
  }
}