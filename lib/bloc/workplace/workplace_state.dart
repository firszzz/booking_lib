part of 'workplace_bloc.dart';

abstract class WorkplaceState extends Equatable {
  const WorkplaceState();
}

class WorkplaceLoadingState extends WorkplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WorkplaceLoadedState extends WorkplaceState{
  final List<Workplace> workplaces;
  // final List<int> officeLevels;
  final List<Floor> floors;


  const WorkplaceLoadedState({
    required this.workplaces,
    required this.floors,
    // required this.officeLevels,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [workplaces, floors];
}


class WorkplaceEmptyState extends WorkplaceState {

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class WorkplaceErrorState extends WorkplaceState {
  final String error;

  const WorkplaceErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
