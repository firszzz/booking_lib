import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/domain/repository/floor_repository.dart';

class FloorDataRepository extends FloorRepository {
  final ApiUtil _apiUtil;

  FloorDataRepository(this._apiUtil);

  @override
  Future<List<Floor>> getOfficeFloors({
    required officeId,
  }) {
    return _apiUtil.getOfficeFloors(officeId: officeId);
  }

  @override
  Future<void> postFloor({
    required int officeId,
    required int floorNumber
  }) {
    return _apiUtil.postFloor(
        officeId: officeId,
        floorNumber: floorNumber,
    );
  }
}