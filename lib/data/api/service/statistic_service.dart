import 'package:atb_flutter_demo/data/api/model/api_statistic.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class StatisticService {
  final Dio _dio = Api().api;

  Future<List<ApiStatistic>> getStatistic({
    required int officeId,
    required timeBegin,
    required timeEnd,
  }) async {
    final response = await _dio.get(
      '/statistics/count-reservations-by-date-office/',
      queryParameters: {
        'officeId': officeId,
        'timeBegin': timeBegin,
        'timeEnd': timeEnd,
        'pageable': {
          "page": 0,
          "size": 15,
          "sort": [""]
        }
      },
    );
    List<ApiStatistic> listStatistic = [];

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['content'];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> map = data[i];
        listStatistic.add(ApiStatistic.fromApi(map));
      }
      return listStatistic;
    } else {
      return listStatistic;
    }
  }
}
