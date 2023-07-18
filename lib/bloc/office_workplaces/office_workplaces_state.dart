part of 'office_workplaces_bloc.dart';

abstract class OfficeWorkplacesState extends Equatable {
  const OfficeWorkplacesState();
}

class OfficeWorkplacesLoadingState extends OfficeWorkplacesState {
  @override
  List<Object> get props => [];
}

class OfficeWorkplacesLoadedState extends OfficeWorkplacesState {
  final List<Workplace> workplaces;
  final List<Floor> floors;

  const OfficeWorkplacesLoadedState({
    required this.workplaces,
    required this.floors,
  });
  @override
  List<Object?> get props => [workplaces, floors];
}

class OfficeWorkplacesErrorState extends OfficeWorkplacesState {
  final String error;

  const OfficeWorkplacesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
