import 'dart:async';

import 'package:atb_flutter_demo/internal/usecases/delete_reservations.dart';
import 'package:atb_flutter_demo/internal/usecases/get_reservations.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/reservation.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final _getReservations = GetReservations();
  final _deleteReservations = DeleteReservations();

  ReservationsBloc() : super(ReservationsLoadingState()) {
    on<LoadReservationsEvent>(_onLoadReservations);
    on<RefreshReservationsEvent>(_onRefreshReservations);
    on<DeleteReservationsEvent>(_onDeleteReservations);
  }

  Future<void> _onLoadReservations(
      LoadReservationsEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsLoadingState());
    try {
      const storage = FlutterSecureStorage();
      var idEmployee = await storage.read(key: 'idEmployee');

      final data = await _getReservations(
        GetReservationsParams(id: (event.id != null) ? event.id! : idEmployee!),
      );
      emit(ReservationsLoadedState(data));
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        emit(ReservationsEmptyState());
      } else {
        emit(ReservationsErrorState(e.toString()));
      }
    }
  }

  Future<void> _onRefreshReservations(
      RefreshReservationsEvent event, Emitter<ReservationsState> emit) async {
    const storage = FlutterSecureStorage();
    var idEmployee = await storage.read(key: 'idEmployee');

    Future<void> refresh() async {
      try {
        final data =
            await _getReservations(
                GetReservationsParams(id: (event.id != null) ? event.id! : idEmployee!),
            );
        emit(ReservationsLoadedState(data));
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(ReservationsEmptyState());
        } else {
          emit(ReservationsErrorState(e.toString()));
        }
      }
    }

    await refresh().timeout(const Duration(seconds: 1));
  }

  Future<void> _onDeleteReservations(
      DeleteReservationsEvent event, Emitter<ReservationsState> emit) async {
    try {
      await _deleteReservations(
          DeleteReservationsParams(id: event.id));
    } on DioError catch (e) {
      emit(ReservationsErrorState(e.toString()));
    }
  }
}
