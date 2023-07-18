import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../dependencies/repository_module.dart';

class DeleteWorkplace extends UseCase<void, DeleteWorkplaceParams> {
  final _workplaceRepository = RepositoryModule.workplaceRepository();

  @override
  Future<void> call(DeleteWorkplaceParams params) async {
    await _workplaceRepository.deleteWorkplace(id: params.id);
  }

}

class DeleteWorkplaceParams extends Equatable{
  final int id;

  const DeleteWorkplaceParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}