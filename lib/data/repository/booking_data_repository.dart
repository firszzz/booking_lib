
import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/booking.dart';

import '../../domain/repository/booking_repository.dart';


class BookingDataRepository extends BookingRepository {
  final ApiUtil _apiUtil;

  BookingDataRepository(this._apiUtil);

  @override
  Future<List<Booking>> getBookings({required String id}) {
    return _apiUtil.getBookings(id: id);
  }
}