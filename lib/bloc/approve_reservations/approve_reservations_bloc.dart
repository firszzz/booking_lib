import 'dart:async';

import 'package:atb_flutter_demo/domain/models/approve_reservation.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../internal/dependencies/repository_module.dart';

part 'approve_reservations_event.dart';
part 'approve_reservations_state.dart';

class ApproveReservationsBloc extends Bloc<ApproveReservationsEvent, ApproveReservationsState> {
  ApproveReservationsBloc() : super(ApproveReservationsLoadingState()) {
    var approveRepository = RepositoryModule.approveReservationRepository();

    on<LoadApproveReservationsEvent>((event, emit) async {
      List<ApproveReservation> data = [];

      try {
        final data = await approveRepository.getApproveReservations(city: event.city!);

        emit(ApproveReservationsLoadedState(data));
      }
      on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          emit(ApproveReservationsLoadedState(data));
        }
        else {
          emit(ApproveReservationsErrorState(e.message));
        }
      }
    });

    on<RefreshApproveReservationsEvent>((event, emit) async {
      List<ApproveReservation> data = [];

      Future<void> refresh() async {
        try {
          final data = await approveRepository.getApproveReservations(city: event.city!);

          emit(ApproveReservationsLoadedState(data));
        }
        on DioError catch (e) {
          if (e.response?.statusCode == 404) {
            emit(ApproveReservationsLoadedState(data));
          }
          else {
            emit(ApproveReservationsErrorState(e.message));
          }
        }
      }

      await refresh().timeout(const Duration(seconds: 1));
    });

    on<DeleteApproveReservationsEvent>((event, emit) async {
      try {
        await approveRepository.deleteApproveReservations(id: event.id);
      }
      on DioError catch (e) {
        emit(ApproveReservationsErrorState(e.message));
      }
    });

    on<ConfirmApproveReservationsEvent>((event, emit) async {
      try {
        await approveRepository.confirmApproveReservations(id: event.id);
      }
      on DioError catch (e) {
        emit(ApproveReservationsErrorState(e.message));
      }
    });
  }
}
