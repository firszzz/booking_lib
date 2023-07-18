import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/office.dart';

class GetOffices extends UseCase<List<Office>, GetOfficesParams> {
  final _officeRepository = RepositoryModule.officeRepository();

  @override
  Future<List<Office>> call(GetOfficesParams params) async {
    return await _officeRepository.getOffices(city: params.city);
  }

}

class GetOfficesParams extends Equatable{
  final String city;

  const GetOfficesParams({
    required this.city
  });

  @override
  List<Object?> get props => [city];
}