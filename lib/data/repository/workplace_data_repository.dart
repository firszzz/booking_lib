import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/workplace.dart';
import 'package:atb_flutter_demo/domain/repository/workplace_repository.dart';

class WorkplaceDataRepository extends WorkplaceRepository {
  final ApiUtil _apiUtil;

  WorkplaceDataRepository(this._apiUtil);

  @override
  Future<List<Workplace>> getWorkplacesByTypeLevel({
    required bool type,
    required int floorId,
    required String sortBy,
  }) {
    return _apiUtil.getWorkplacesByTypeLevel(
        type: type,
        floorId: floorId,
        sortBy: sortBy,
    );
  }

  @override
  Future<void> postWorkplace({
    required bool type,
    required int seatsCount,
    required int floorId,
    required String info,
  }) {
    return _apiUtil.postWorkplace(
        type: type,
        seatsCount: seatsCount,
        floorId: floorId,
        info: info,
    );
  }

  @override
  Future<void> deleteWorkplace({
    required int id
  }) {
    return _apiUtil.deleteWorkplace(id: id);
  }

}