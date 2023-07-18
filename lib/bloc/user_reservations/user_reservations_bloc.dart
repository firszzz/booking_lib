import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/reservation.dart';
import '../../internal/dependencies/repository_module.dart';
import '../../internal/usecases/delete_reservations.dart';

part 'user_reservations_event.dart';
part 'user_reservations_state.dart';

class UserReservationsBloc extends Bloc<UserReservationsEvent, UserReservationsState> {
  final _deleteReservations = DeleteReservations();
  final _reservationsRepository = RepositoryModule.reservationRepository();

  UserReservationsBloc() : super(UserReservationsLoadingState()) {
    on<LoadUserReservationsEvent>(_onLoadUserReservations);
    on<RefreshUserReservationsEvent>(_onRefreshUserReservations);
    on<DeleteUserReservations>(_onDeleteUserReservations);
  }

  Future<void> _onLoadUserReservations(LoadUserReservationsEvent event, Emitter<UserReservationsState> emit) async {
    emit(UserReservationsLoadingState());
    const storage = FlutterSecureStorage();
    var idEmployee = await storage.read(key: 'idEmployee');

    List<Reservation> confirmedReservations = [];
    List<Reservation> unconfirmedReservations = [];
    try {
      final data = await _reservationsRepository.getConfirmedReservations(id: idEmployee!, confirmed: true);

      for (int i = 0; i < data.length; i++) {
        confirmedReservations.add(data[i]);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        confirmedReservations = [];
      } else {
        emit(UserReservationsErrorState(e.toString()));
      }
    }
    try {
      final data = await _reservationsRepository.getConfirmedReservations(id: idEmployee!, confirmed: false);

      for (int i = 0; i < data.length; i++) {
        unconfirmedReservations.add(data[i]);
      }

    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        unconfirmedReservations = [];
      } else {
        emit(UserReservationsErrorState(e.toString()));
      }
    }
    emit(UserReservationsLoadedState(
      confirmedReservations: confirmedReservations,
      unconfirmedReservations: unconfirmedReservations,
    ));
  }

  Future<void> _onDeleteUserReservations(DeleteUserReservations event, Emitter<UserReservationsState> emit) async {
    try {
      await _deleteReservations(
          DeleteReservationsParams(id: event.id));
    } on DioError catch (e) {
      emit(UserReservationsErrorState(e.toString()));
    }
  }

  Future<void> _onRefreshUserReservations(RefreshUserReservationsEvent event, Emitter<UserReservationsState> emit) async {
    const storage = FlutterSecureStorage();
    var idEmployee = await storage.read(key: 'idEmployee');

    Future<void> refresh() async {
      List<Reservation> confirmedReservations = [];
      List<Reservation> unconfirmedReservations = [];
      try {
        final data = await _reservationsRepository.getConfirmedReservations(id: idEmployee!, confirmed: true);

        for (int i = 0; i < data.length; i++) {
          confirmedReservations.add(data[i]);
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          confirmedReservations = [];
        } else {
          emit(UserReservationsErrorState(e.toString()));
        }
      }
      try {
        final data = await _reservationsRepository.getConfirmedReservations(id: idEmployee!, confirmed: false);

        for (int i = 0; i < data.length; i++) {
          unconfirmedReservations.add(data[i]);
        }

      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          unconfirmedReservations = [];
        } else {
          emit(UserReservationsErrorState(e.toString()));
        }
      }
      emit(UserReservationsLoadedState(
        confirmedReservations: confirmedReservations,
        unconfirmedReservations: unconfirmedReservations,
      ));
    }

    await refresh().timeout(const Duration(seconds: 1));
  }
}
