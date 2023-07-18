import 'package:atb_flutter_demo/domain/models/workplace.dart';

abstract class WorkplaceRepository {
  Future<List<Workplace>> getWorkplacesByTypeLevel({
    required bool type,
    required int floorId,
    required String sortBy,
  });

  Future<void> postWorkplace({
    required bool type,
    required int seatsCount,
    required int floorId,
    required String info,
  });

  Future<void> deleteWorkplace({
    required int id,
  });
}