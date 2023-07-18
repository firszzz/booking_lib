part of 'workplace_info_bloc.dart';

abstract class WorkplaceInfoState extends Equatable {
  const WorkplaceInfoState();
}

class WorkplaceInfoInitial extends WorkplaceInfoState {
  @override
  List<Object> get props => [];
}

class WorkplaceInfoLoadedState extends WorkplaceInfoState {
  final String basicAuth;

  const WorkplaceInfoLoadedState(this.basicAuth);
  @override
  List<Object> get props => [basicAuth];
}
