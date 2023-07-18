import 'package:atb_flutter_demo/domain/models/workplace.dart';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetWorkplacesByTypeLevel extends UseCase<List<Workplace>, GetWorkplacesByTypeLevelParams> {
  final _workplaceRepository = RepositoryModule.workplaceRepository();

  @override
  Future<List<Workplace>> call(GetWorkplacesByTypeLevelParams params) async {
    return await _workplaceRepository.getWorkplacesByTypeLevel(
        type: params.type,
        floorId: params.floorId,
        sortBy: params.sortBy,
    );
  }
}

class GetWorkplacesByTypeLevelParams extends Equatable {
  final bool type;
  final int floorId;
  final String sortBy;

  const GetWorkplacesByTypeLevelParams({
    required this.type,
    required this.floorId,
    required this.sortBy,
  });

  @override
  List<Object?> get props => [type, floorId, sortBy];
}