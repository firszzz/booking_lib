part of 'user_reservations_bloc.dart';

abstract class UserReservationsEvent extends Equatable {
  const UserReservationsEvent();
}

class LoadUserReservationsEvent extends UserReservationsEvent {

  @override
  List<Object?> get props => [];
}

class RefreshUserReservationsEvent extends UserReservationsEvent {


  @override
  List<Object?> get props => [];
}

class DeleteUserReservations extends UserReservationsEvent {
  final String id;

  const DeleteUserReservations(this.id);

  @override
  List<Object?> get props => [id];
}