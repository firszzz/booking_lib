import 'package:atb_flutter_demo/domain/models/statistic.dart';

abstract class StatisticRepository {
  Future<List<Statistic>> getStatistic({
    required int officeId,
    required timeBegin,
    required timeEnd,
  });
}
