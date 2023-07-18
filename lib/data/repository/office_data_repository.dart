import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:atb_flutter_demo/domain/repository/office_repository.dart';

class OfficeDataRepository extends OfficeRepository {
  final ApiUtil _apiUtil;

  OfficeDataRepository(this._apiUtil);

  @override
  Future<List<int>> getOfficeLevels({
    required String id,
  }) {
    return _apiUtil.getOfficeLevels(id: id);
  }

  @override
  Future<List<Office>> getOfficeInfo({required String id}) {
    return _apiUtil.getOfficeInfo(id: id);
  }

  @override
  Future<List<String>> getCities() {
    return _apiUtil.getCities();
  }

  @override
  Future<List<Office>> getOffices({required String city}) {
    return _apiUtil.getOffices(city: city);
  }

  @override
  Future<void> postOffice({
    required String timeBegin,
    required String timeEnd,
    required bool access,
    required String city,
    required int numDay,
    required String address,
    required String timeZone,
  }) {
    return _apiUtil.postOffice(
        timeBegin: timeBegin,
        timeEnd: timeEnd,
        access: access,
        city: city,
        numDay: numDay,
        address: address,
        timeZone: timeZone,
    );
  }
}
