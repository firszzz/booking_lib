part of 'approve_reservations_bloc.dart';

abstract class ApproveReservationsEvent extends Equatable {
  const ApproveReservationsEvent();
}

class LoadApproveReservationsEvent extends ApproveReservationsEvent {
  final String? city;

  const LoadApproveReservationsEvent({
    this.city,
  });

  @override
  List<Object?> get props => [city];
}

class RefreshApproveReservationsEvent extends ApproveReservationsEvent {
  final String? city;

  const RefreshApproveReservationsEvent({
    this.city,
  });

  @override
  List<Object?> get props => [city];
}


class DeleteApproveReservationsEvent extends ApproveReservationsEvent {
  final String id;

  const DeleteApproveReservationsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ConfirmApproveReservationsEvent extends ApproveReservationsEvent {
  final String id;

  const ConfirmApproveReservationsEvent(this.id);

  @override
  List<Object?> get props => [id];
}