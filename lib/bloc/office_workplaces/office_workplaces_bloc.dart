import 'dart:async';

import 'package:atb_flutter_demo/domain/models/workplace.dart';
import 'package:atb_flutter_demo/internal/usecases/delete_workplace.dart';
import 'package:atb_flutter_demo/internal/usecases/get_office_floors.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/floor.dart';
import '../../internal/usecases/get_workplaces.dart';

part 'office_workplaces_event.dart';
part 'office_workplaces_state.dart';

class OfficeWorkplacesBloc
    extends Bloc<OfficeWorkplacesEvent, OfficeWorkplacesState> {
  final _getWorkplaces = GetWorkplacesByTypeLevel();
  final _getFloors = GetOfficeFloors();
  final _deleteWorkplace = DeleteWorkplace();

  List<Floor> floors = [];

  OfficeWorkplacesBloc() : super(OfficeWorkplacesLoadingState()) {
    on<LoadOfficeWorkplacesEvent>(_onLoadOfficeWorkplaces);
    on<UpdateOfficeWorkplacesEvent>(_onUpdateOfficeWorkplaces);
    on<DeleteOfficeWorkplacesEvent>(_onDeleteOfficeWorkplaces);
    on<ChangeFloorWorkplacesEvent>(_onChangeFloorWorkplaces);

  }

  Future<void> _onLoadOfficeWorkplaces(LoadOfficeWorkplacesEvent event, Emitter<OfficeWorkplacesState> emit) async {
    emit(OfficeWorkplacesLoadingState());
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;
      final data = await _getWorkplaces(
        GetWorkplacesByTypeLevelParams(
          type: event.type,
          floorId: floors.first.id,
          sortBy: event.sortBy,
        ),
      );
      emit(OfficeWorkplacesLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(OfficeWorkplacesLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(OfficeWorkplacesErrorState(e.toString()));
      }
    }
  }

  Future<void> _onUpdateOfficeWorkplaces(UpdateOfficeWorkplacesEvent event, Emitter<OfficeWorkplacesState> emit) async {
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;
      final data = await _getWorkplaces(
        GetWorkplacesByTypeLevelParams(
          type: event.type,
          floorId: event.floorId,
          sortBy: event.sortBy,
        ),
      );
      emit(OfficeWorkplacesLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(OfficeWorkplacesLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(OfficeWorkplacesErrorState(e.toString()));
      }
    }
  }



  Future<void> _onDeleteOfficeWorkplaces(DeleteOfficeWorkplacesEvent event, Emitter<OfficeWorkplacesState> emit) async {
    try {
      await _deleteWorkplace(DeleteWorkplaceParams(id: event.id));
    } on DioError catch (e) {
      emit(OfficeWorkplacesErrorState(e.toString()));
    }
  }

  Future<void> _onChangeFloorWorkplaces(ChangeFloorWorkplacesEvent event, Emitter<OfficeWorkplacesState> emit) async {
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;

      final data = await _getWorkplaces(GetWorkplacesByTypeLevelParams(
        type: event.type,
        floorId: event.floorId,
        sortBy: event.sortBy,
      ));
      print(data);
      emit(OfficeWorkplacesLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print('error calling');
        emit(OfficeWorkplacesLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(OfficeWorkplacesErrorState(e.toString()));
      }
    }
  }
}
