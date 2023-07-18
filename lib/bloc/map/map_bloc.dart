import 'dart:async';
import 'dart:convert';

import 'package:atb_flutter_demo/internal/usecases/get_office_floors.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/floor.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final _getFloors = GetOfficeFloors();

  MapBloc() : super(MapLoadingState()) {
    on<LoadMapEvent>(_onLoadMap);
  }

  Future<void> _onLoadMap(LoadMapEvent event, Emitter<MapState> emit) async {
    emit(MapLoadingState());

    const storage = FlutterSecureStorage();
    var login = await storage.read(key: 'login');
    var password = await storage.read(key: 'password');

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';

    List<Floor> floors = [];
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;

      emit(MapLoadedState(
        floors: floors,
        basicAuth: basicAuth,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(MapLoadedState(floors: floors, basicAuth: basicAuth));
      } else {
        emit(MapErrorState(e.toString()));
      }
    }
  }
}
