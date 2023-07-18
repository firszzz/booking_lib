import 'dart:async';

import 'package:atb_flutter_demo/data/api/service/statistic_service.dart';
import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:atb_flutter_demo/domain/models/statistic.dart';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../internal/dependencies/repository_module.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticLoadingState()) {
    on<StatisticEvent>((event, emit) async {

    });
    on<LoadStatisticEvent>((event, emit) async {
      var officeRepository = RepositoryModule.officeRepository();
      var statisticRepository = RepositoryModule.statisticRepository();

      List<Office> listOffices = [];
      List<Statistic> listStatistic = [];
      List<String> listOfficeNames = [];

      try {
        final data = await officeRepository.getOffices(city: event.city);

        for (var el in data) {
          listOffices.add(el);
          listOfficeNames.add(el.address);
        }
      }
      on DioError catch (e) {
        if (e.response?.statusCode != 400) {
          debugPrint(e.toString());
        }
      }

      try {
        final data = await statisticRepository.getStatistic(officeId: event.idOffice, timeBegin: event.timeBegin, timeEnd: event.timeEnd);

        for (var el in data) {
          listStatistic.add(el);
        }

        emit(StatisticLoadedState(listStatistic, listOffices, listOfficeNames));
      }
      on DioError catch (e) {
        if (e.response?.statusCode == 400) {
          emit(StatisticLoadedState(listStatistic, listOffices, listOfficeNames));
        }
      }
    });
    on<ChangeOfficeStatisticEvent>((event, emit) async {
      var officeRepository = RepositoryModule.officeRepository();
      var statisticRepository = RepositoryModule.statisticRepository();

      List<Office> listOffices = [];
      List<Statistic> listStatistic = [];
      List<String> listOfficeNames = [];

      try {
        final data = await officeRepository.getOffices(city: event.city);

        for (var el in data) {
          listOffices.add(el);
          listOfficeNames.add(el.address);
        }
      }
      on DioError catch (e) {
        if (e.response?.statusCode != 400) {
          debugPrint(e.toString());
        }
      }

      try {
        final data = await statisticRepository.getStatistic(officeId: event.idOffice, timeBegin: event.timeBegin, timeEnd: event.timeEnd);

        for (var el in data) {
          listStatistic.add(el);
        }

        emit(StatisticLoadedState(listStatistic, listOffices, listOfficeNames));
      }
      on DioError catch (e) {
        if (e.response?.statusCode == 400) {
          emit(StatisticLoadedState(listStatistic, listOffices, listOfficeNames));
        }
      }
    });
  }
}
