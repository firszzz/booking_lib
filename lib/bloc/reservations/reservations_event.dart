part of 'reservations_bloc.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();
}

class LoadReservationsEvent extends ReservationsEvent {
  final String? id;

  const LoadReservationsEvent({
    this.id,
  });

  @override
  List<Object?> get props => [id];
}

class RefreshReservationsEvent extends ReservationsEvent {
  final String? id;

  const RefreshReservationsEvent({
    this.id,
  });

  @override
  List<Object?> get props => [id];
}


class DeleteReservationsEvent extends ReservationsEvent {
  final String id;

  const DeleteReservationsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
