import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetOfficeFloors extends UseCase<List<Floor>, GetOfficeFloorsParams> {
  final _floorRepository = RepositoryModule.floorRepository();

  @override
  Future<List<Floor>> call(GetOfficeFloorsParams params) {
    return _floorRepository.getOfficeFloors(officeId: params.officeId);
  }

}

class GetOfficeFloorsParams extends Equatable{
  final int officeId;

  const GetOfficeFloorsParams(this.officeId);

  @override
  List<Object?> get props => [officeId];
}