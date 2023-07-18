part of 'office_bloc.dart';

abstract class OfficeState extends Equatable {
  const OfficeState();
}

class OfficeLoadingState extends OfficeState {
  @override
  List<Object> get props => [];
}

class OfficeLoadedState extends OfficeState {
  final List<String> cities;
  final List<Office> offices;

  const OfficeLoadedState({
     required this.cities,
     required this.offices,
  });

  @override
  List<Object> get props => [cities, offices];
}

class OfficeErrorState extends OfficeState {
  final String error;

  const OfficeErrorState(this.error);

  @override
  List<Object> get props => [error];
}