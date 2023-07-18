import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/office.dart';
import '../../internal/usecases/get_cities.dart';
import '../../internal/usecases/get_offices.dart';

part 'office_event.dart';
part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  final _getCities = GetCities();
  final _getOffices = GetOffices();

  OfficeBloc() : super(OfficeLoadingState()) {
    on<LoadOfficeEvent>(_onLoadOffice);
    on<ChangeCityEvent>(_onChangeCity);
    on<UpdateOfficesEvent>(_onUpdateOffices);
  }

  FutureOr<void> _onLoadOffice(LoadOfficeEvent event, Emitter<OfficeState> emit) async {
    emit(OfficeLoadingState());
    try {
      final cities = await _getCities(GetCitiesParams());
      final data = await _getOffices(
        GetOfficesParams(city: event.city),
      );
      emit(OfficeLoadedState(
        cities: cities,
        offices: data,
      ));
    } on DioError catch (e) {
      emit(OfficeErrorState(e.toString()));
    }
  }

  Future<void> _onChangeCity(ChangeCityEvent event, Emitter<OfficeState> emit) async {
    try {
      final data = await _getOffices(
        GetOfficesParams(city: event.city),
      );
      emit(OfficeLoadedState(
        cities: event.cities,
        offices: data,
      ));
    } on DioError catch (e) {
      emit(OfficeErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateOffices(UpdateOfficesEvent event, Emitter<OfficeState> emit) async {
    try {
      final cities = await _getCities(GetCitiesParams());
      final data = await _getOffices(
        GetOfficesParams(city: cities.first),
      );
      emit(OfficeLoadedState(cities: cities, offices: data));
    } on DioError catch (e) {
      emit(OfficeErrorState(e.toString()));
    }
  }
}