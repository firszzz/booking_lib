import 'dart:async';

import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:atb_flutter_demo/internal/usecases/get_cities.dart';
import 'package:atb_flutter_demo/internal/usecases/get_office_floors.dart';
import 'package:atb_flutter_demo/internal/usecases/get_offices.dart';
import 'package:atb_flutter_demo/internal/usecases/get_offices_addresses.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/floor.dart';

part 'first_time_event.dart';
part 'first_time_state.dart';

class FirstTimeBloc extends Bloc<FirstTimeEvent, FirstTimeState> {
  final _getCities = GetCities();
  final _getOffices = GetOffices();
  final _getFloors = GetOfficeFloors();

  FirstTimeBloc() : super(FirstTimeLoadingState()) {
    on<LoadFirstTimeEvent>(_onLoadFirstTime);
    on<ChangeCityFirstTimeEvent>(_onChangeCityFirstTime);
    on<SetFloorFirstTimeEvent>(_onSetFloorFirstTime);
  }

  Future<void> _onLoadFirstTime(LoadFirstTimeEvent event, Emitter<FirstTimeState> emit) async {
    emit(FirstTimeLoadingState());
    try {
      final cities = await _getCities(GetCitiesParams());
      emit(FirstTimeLoadedState(
        cities: cities,
        offices: [],
        floors: [],
      ));
    } on DioError catch (e) {
      emit(FirstTimeErrorState(error: e.toString()));
    }
  }

  Future<void> _onChangeCityFirstTime(ChangeCityFirstTimeEvent event, Emitter<FirstTimeState> emit) async {
    try {
      final cities = await _getCities(GetCitiesParams());
      final offices = await _getOffices(GetOfficesParams(city: event.city));
      emit(FirstTimeLoadedState(
        cities: cities,
        offices: offices,
        floors: [],
      ));
    } on DioError catch (e) {
      emit(FirstTimeErrorState(error: e.toString()));
    }
  }

  Future<void> _onSetFloorFirstTime(SetFloorFirstTimeEvent event, Emitter<FirstTimeState> emit) async {
    try {
      final cities = await _getCities(GetCitiesParams());
      final offices = await _getOffices(GetOfficesParams(city: event.city));
      final floors = await _getFloors(GetOfficeFloorsParams(event.officeId));
      emit(FirstTimeLoadedState(
        cities: cities,
        offices: offices,
        floors: floors,
      ));
    } on DioError catch (e) {
      emit(FirstTimeErrorState(error: e.toString()));
    }
  }
}
