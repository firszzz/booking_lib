import 'dart:async';

import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../internal/usecases/get_cities.dart';
import '../../internal/usecases/get_offices.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final _getCities = GetCities();
  final _getOffices = GetOffices();

  FilterBloc() : super(FilterLoadingState()) {
    on<LoadFiltersEvent>(_onLoadFilter);
    on<UpdateOfficesFilterEvent>(_onUpdateOfficesFilter);
  }

  List<String> cities = [];

  Future<void> _onLoadFilter(LoadFiltersEvent event, Emitter<FilterState> emit) async {
    try {
      final citiesData = await _getCities(
        GetCitiesParams(),
      );
      cities = citiesData;

      final offices = await _getOffices(GetOfficesParams(city: event.city));
      emit(FilterLoadedState(
        cities: cities,
        offices: offices,
      ));
    } on DioError catch (e) {
      emit(FilterErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateOfficesFilter(UpdateOfficesFilterEvent event, Emitter<FilterState> emit) async {
    try {
      final offices = await _getOffices(GetOfficesParams(city: event.city));
      emit(FilterLoadedState(
        cities: cities,
        offices: offices,
      ));
    } on DioError catch (e) {
      emit(FilterErrorState(e.toString()));
    }
  }
}
