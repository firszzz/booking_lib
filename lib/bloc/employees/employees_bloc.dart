import 'dart:async';

import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/user.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final _userRepository = RepositoryModule.userRepository();
  
  EmployeesBloc() : super(EmployeesLoadingState()) {
    on<LoadEmployeesEvent>(_onLoadEmployees);
  }

  Future<void> _onLoadEmployees(LoadEmployeesEvent event, Emitter<EmployeesState> emit) async {
    emit(EmployeesLoadingState());
    try {
      final data = await _userRepository.getAllUsers();
      emit(EmployeesLoadedState(data));
    } on DioError catch (e) {
      emit(EmployeesErrorState(e.toString()));
    }
  }
}
