part of 'first_time_bloc.dart';

abstract class FirstTimeEvent extends Equatable {
  const FirstTimeEvent();
}

class LoadFirstTimeEvent extends FirstTimeEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCityFirstTimeEvent extends FirstTimeEvent {
  final String city;

  const ChangeCityFirstTimeEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class SetFloorFirstTimeEvent extends FirstTimeEvent {
  final String city;
  final int officeId;

  const SetFloorFirstTimeEvent({
    required this.city,
    required this.officeId,
  });

  @override
  List<Object?> get props => [city, officeId];
}
