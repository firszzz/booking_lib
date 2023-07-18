import 'dart:async';

import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'admin_office_event.dart';
part 'admin_office_state.dart';

class AdminOfficeBloc extends Bloc<AdminOfficeEvent, AdminOfficeState> {
  final _officeRepository = RepositoryModule.officeRepository();

  AdminOfficeBloc() : super(AdminOfficeInitial()) {
    on<CreateOfficeEvent>(_onCreateOffice);
  }

  Future<void> _onCreateOffice(CreateOfficeEvent event, Emitter<AdminOfficeState> emit) async {
    emit(AdminOfficeAdding());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _officeRepository.postOffice(
          timeBegin: event.timeBegin,
          timeEnd: event.timeEnd,
          access: event.access,
          city: event.city,
          numDay: event.numDay,
          address: event.address,
          timeZone: event.timeZone,
      );
      emit(AdminOfficeAdded());
    } on DioError catch (e) {
      emit(AdminOfficeError(e.toString()));
    }
  }
}
