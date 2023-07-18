part of 'approve_reservations_bloc.dart';

abstract class ApproveReservationsState extends Equatable {
  const ApproveReservationsState();
}

class ApproveReservationsLoadingState extends ApproveReservationsState {
  @override
  List<Object?> get props => [];
}

class ApproveReservationsLoadedState extends ApproveReservationsState {
  final List<ApproveReservation> reservations;

  const ApproveReservationsLoadedState(this.reservations);

  @override
  List<Object?> get props => [reservations];
}

class ApproveReservationsEmptyState extends ApproveReservationsState {
  @override
  List<Object?> get props => [];
}

class ApproveReservationsErrorState extends ApproveReservationsState {
  final String error;

  const ApproveReservationsErrorState(this.error);

  @override
  List<Object?> get props => [];
}
