part of 'first_time_bloc.dart';

abstract class FirstTimeState extends Equatable {
  const FirstTimeState();
}

class FirstTimeLoadingState extends FirstTimeState {
  @override
  List<Object> get props => [];
}

class FirstTimeLoadedState extends FirstTimeState {
  final List<String> cities;
  final List<Office> offices;
  final List<Floor> floors;

  const FirstTimeLoadedState({
    required this.cities,
    required this.offices,
    required this.floors,
  });

  @override
  List<Object> get props => [cities, offices, floors];
}

class FirstTimeErrorState extends FirstTimeState {
  final String error;

  const FirstTimeErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
