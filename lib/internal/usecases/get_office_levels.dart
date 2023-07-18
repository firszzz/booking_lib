import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetOfficeLevels extends UseCase<List<int>, GetOfficeLevelsParams> {
  final _officeRepository = RepositoryModule.officeRepository();

  @override
  Future<List<int>> call(GetOfficeLevelsParams params) {
    return _officeRepository.getOfficeLevels(id: params.id);
  }
}

class GetOfficeLevelsParams extends Equatable{
  final String id;

  const GetOfficeLevelsParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
