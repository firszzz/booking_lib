import 'dart:async';

import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'admin_workplace_event.dart';
part 'admin_workplace_state.dart';

class AdminWorkplaceBloc extends Bloc<AdminWorkplaceEvent, AdminWorkplaceState> {
  final _workplaceRepository = RepositoryModule.workplaceRepository();
  final _floorRepository = RepositoryModule.floorRepository();

  AdminWorkplaceBloc() : super(AdminWorkplaceInitial()) {
    on<CreateWorkplaceEvent>(_onCreateWorkplace);
  }

  Future<void> _onCreateWorkplace(CreateWorkplaceEvent event, Emitter<AdminWorkplaceState> emit) async {
    emit(AdminWorkplaceAdding());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _floorRepository.postFloor(officeId: event.officeId, floorNumber: event.floorNumber);
    } on DioError catch (e) {
      if (e.response?.statusCode != 400) {
        print(e.message);
      }
    }
    try {
      final floors = await _floorRepository.getOfficeFloors(officeId: event.officeId);
      for (var item in floors) {
        if (item.floorNumber == event.floorNumber) {
          await _workplaceRepository.postWorkplace(
            type: event.type,
            seatsCount: event.seatsCount,
            floorId: item.id,
            info: event.info,
          );
        }
      }

      emit(AdminWorkplaceAdded());
    } on DioError catch (e) {
      emit(AdminWorkplaceError(e.toString()));
    }
  }
}
