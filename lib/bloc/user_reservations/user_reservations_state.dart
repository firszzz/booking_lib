part of 'user_reservations_bloc.dart';

abstract class UserReservationsState extends Equatable {
  const UserReservationsState();
}

class UserReservationsLoadingState extends UserReservationsState {
  @override
  List<Object> get props => [];
}

class UserReservationsLoadedState extends UserReservationsState {
  final List<Reservation> confirmedReservations;
  final List<Reservation> unconfirmedReservations;

  const UserReservationsLoadedState({
    required this.confirmedReservations,
    required this.unconfirmedReservations,
  });

  @override
  List<Object?> get props => [confirmedReservations, unconfirmedReservations];
}

class UserReservationsErrorState extends UserReservationsState {
  final String error;

  const UserReservationsErrorState(this.error);

  @override
  List<Object> get props => [];
}
