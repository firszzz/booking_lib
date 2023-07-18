import 'package:atb_flutter_demo/domain/models/floor.dart';

abstract class FloorRepository {
  Future<List<Floor>> getOfficeFloors({
    required officeId,
  });

  Future<void> postFloor({
    required int officeId,
    required int floorNumber,
  });
}