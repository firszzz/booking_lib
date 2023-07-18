import 'dart:async';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/get_cities.dart';
import 'package:atb_flutter_demo/internal/usecases/get_office_floors.dart';
import 'package:atb_flutter_demo/internal/usecases/get_office_levels.dart';
import 'package:atb_flutter_demo/internal/usecases/get_offices.dart';
import 'package:atb_flutter_demo/internal/usecases/get_workplaces.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/floor.dart';
import '../../domain/models/workplace.dart';

part 'workplace_event.dart';
part 'workplace_state.dart';

class WorkplaceBloc extends Bloc<WorkplaceEvent, WorkplaceState> {
  final _getWorkplaces = GetWorkplacesByTypeLevel();
  final _getFloors = GetOfficeFloors();

  List<Floor> floors = [];

  WorkplaceBloc() : super(WorkplaceLoadingState()) {
    on<LoadWorkplaceEvent>(_onLoadWorkplace);
    on<UpdateWorkplaceEvent>(_onUpdateWorkplace);
    on<ChangeOfficeWorkplaceEvent>(_onChangeOfficeWorkplace);
    on<ChangeFloorWorkplaceEvent>(_onChangeFloorWorkplace);
  }

  Future<void> _onLoadWorkplace(LoadWorkplaceEvent event,
      Emitter<WorkplaceState> emit) async {
    emit(WorkplaceLoadingState());
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;

      final data = await _getWorkplaces(
        GetWorkplacesByTypeLevelParams(
          type: event.type,
          floorId: event.floorId,
          sortBy: event.sortBy,
        ),);

      emit(WorkplaceLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(WorkplaceLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(WorkplaceErrorState(e.toString()));
      }
    }
  }

  Future<void> _onUpdateWorkplace(UpdateWorkplaceEvent event,
      Emitter<WorkplaceState> emit) async {
    Future<void> update() async {
      try {
        // final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
        // floors = floorsData;

        final data = await _getWorkplaces(GetWorkplacesByTypeLevelParams(
          type: event.type,
          floorId: event.floorId,
          sortBy: event.sortBy,
        ));
        emit(WorkplaceLoadedState(
          workplaces: data,
          floors: floors,
        ));
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(WorkplaceLoadedState(
            workplaces: const [],
            floors: floors,
          ));
        } else {
          emit(WorkplaceErrorState(e.toString()));
        }
      }
    }

    await update().timeout(const Duration(seconds: 1));
  }

  Future<void> _onChangeOfficeWorkplace(ChangeOfficeWorkplaceEvent event, Emitter<WorkplaceState> emit) async {
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;
      final data = await _getWorkplaces(GetWorkplacesByTypeLevelParams(
        type: event.type,
        floorId: floors.first.id,
        sortBy: event.sortBy,
      ));
      emit(WorkplaceLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(WorkplaceLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(WorkplaceErrorState(e.toString()));
      }
    }
  }

  Future<void> _onChangeFloorWorkplace(ChangeFloorWorkplaceEvent event, Emitter<WorkplaceState> emit) async {
    try {
      final floorsData = await _getFloors(GetOfficeFloorsParams(event.officeId));
      floors = floorsData;

      final data = await _getWorkplaces(GetWorkplacesByTypeLevelParams(
        type: event.type,
        floorId: event.floorId,
        sortBy: event.sortBy,
      ));
      emit(WorkplaceLoadedState(
        workplaces: data,
        floors: floors,
      ));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(WorkplaceLoadedState(
          workplaces: const [],
          floors: floors,
        ));
      } else {
        emit(WorkplaceErrorState(e.toString()));
      }
    }
  }
}
