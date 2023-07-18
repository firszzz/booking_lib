import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetCities extends UseCase<List<String>, GetCitiesParams> {
  final _officeRepository = RepositoryModule.officeRepository();

  @override
  Future<List<String>> call(GetCitiesParams params) async {
    return await _officeRepository.getCities();
  }
}

class GetCitiesParams extends Equatable{
  @override
  List<Object?> get props => [];
}