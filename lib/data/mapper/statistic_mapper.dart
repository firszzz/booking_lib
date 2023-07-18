

import 'package:atb_flutter_demo/data/api/model/api_statistic.dart';

import '../../domain/models/statistic.dart';

class StatisticMapper {
  static Statistic fromApi(ApiStatistic apiStatistic) {
    String idWorkplace = 'Место №${apiStatistic.idWorkplace}';

    return Statistic(
      idWorkplace,
      apiStatistic.countReservations,
    );
  }
}