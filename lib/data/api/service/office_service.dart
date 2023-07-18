import 'package:atb_flutter_demo/data/api/model/api_office.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:dio/dio.dart';

import '../request/api.dart';

class OfficeService {
  final Dio _dio = Api().api;

  Future<List<ApiOffice>> getOfficeInfo({
    required String id,
  }) async {
    final response = await _dio.get(
      '/offices/$id',
    );

    List<ApiOffice> listApiOffices = [];

    if (response.statusCode == 200) {
      final data = response.data;
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> map = data;
        listApiOffices.add(ApiOffice.fromApi(map));
      }
      return listApiOffices;
    } else {
      return listApiOffices;
    }

  }

  Future<List<int>> getOfficeLevels({
    required String id,
  }) async {
    final response = await _dio.get(
      '/offices/get-office-levels?id=$id&page=0&size=100&sort=',
    );
    final Map<String, dynamic> data = response.data;
    final List<int> officeLevels = [];
    for (int i = 0; i < data['content'].length; i++) {
      officeLevels.add(data['content'][i]);
    }
    return officeLevels;
  }

  Future<List<String>> getCities() async {
    final response = await _dio.get(
      AppUrls.getCities,
    );

    final Map<String, dynamic> data = response.data;
    final List<String> cities = [];
    for (int i = 0; i < data['content'].length; i++) {
      cities.add(data['content'][i]);
    }
    return cities;
  }

  Future<List<ApiOffice>> getOffices({
    required String city,
  }) async {
    final response = await _dio.get(
      '/offices/get-by-city?city=$city&page=0&size=100&sort=id',
    );

    final Map<String, dynamic> data = response.data;
    List<ApiOffice> listApiOffices = [];
    for (int i = 0; i < data['content'].length; i++) {
      Map<String, dynamic> map = data['content'][i];
      listApiOffices.add(ApiOffice.fromApi(map));
    }
    return listApiOffices;
  }

  Future<void> postOffice({
    required String timeBegin,
    required String timeEnd,
    required bool access,
    required String city,
    required int numDay,
    required String address,
    required String timeZone,
  }) async {

    await _dio.post(
      '/offices/?timeBegin=$timeBegin&timeEnd=$timeEnd&access=$access&city=$city&numDay=$numDay&address=$address&timeZone=$timeZone',
      /*data: {
        'timeBegin': '08:00',
        'timeEnd': '22:00',
        'access': access,
        'city': city,
        'numDay': numDay,
        'address': address,
        'timeZone': 'UTC+10',
      },*/
    );
  }
}
