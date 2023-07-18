import 'package:atb_flutter_demo/domain/models/statistic.dart';

import '../../domain/repository/statistic_repository.dart';
import '../api/api_util.dart';

class StatisticDataRepository extends StatisticRepository {
  final ApiUtil _apiUtil;

  StatisticDataRepository(this._apiUtil);

  @override
  Future<List<Statistic>> getStatistic({
    required int officeId,
    required timeBegin,
    required timeEnd,
  }) {
    return _apiUtil.getStatistic(officeId: officeId, timeBegin: timeBegin, timeEnd: timeEnd);
  }
}