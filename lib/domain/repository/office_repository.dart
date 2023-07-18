import '../models/office.dart';

abstract class OfficeRepository {
  Future<List<int>> getOfficeLevels({
    required String id,
  });

  Future<List<String>> getCities();

  Future<List<Office>> getOfficeInfo({
    required String id
  });

  Future<List<Office>> getOffices({
    required String city,
  });

  Future<void> postOffice({
    required String timeBegin,
    required String timeEnd,
    required bool access,
    required String city,
    required int numDay,
    required String address,
    required String timeZone,
  });
}
