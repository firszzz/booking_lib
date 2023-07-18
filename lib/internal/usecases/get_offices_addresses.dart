import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetOfficesAddresses extends UseCase<Map<int, String>, GetOfficesAddressesParams> {
  final _officeRepository = RepositoryModule.officeRepository();

  @override
  Future<Map<int, String>> call(GetOfficesAddressesParams params) async {
    final data = await _officeRepository.getOffices(city: params.city);

    Map<int, String> officesAddress = {};
    for (int i = 0; i < data.length; i++) {
      officesAddress[data[i].id] = data[i].address;
    }
    return officesAddress;
  }

}

class GetOfficesAddressesParams extends Equatable{
  final String city;

  const GetOfficesAddressesParams({
    required this.city
  });

  @override
  List<Object?> get props => [city];
}