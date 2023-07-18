part of 'reservations_bloc.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();
}

class ReservationsLoadingState extends ReservationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReservationsLoadedState extends ReservationsState {
  final List<Reservation> reservations;

  const ReservationsLoadedState(this.reservations);

  @override
  // TODO: implement props
  List<Object?> get props => [reservations];
}

class ReservationsEmptyState extends ReservationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReservationsErrorState extends ReservationsState {
  final String error;

  const ReservationsErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
