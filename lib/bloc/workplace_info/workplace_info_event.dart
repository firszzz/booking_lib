part of 'workplace_info_bloc.dart';

abstract class WorkplaceInfoEvent extends Equatable {
  const WorkplaceInfoEvent();
}

class WorkplaceInfoLoadEvent extends WorkplaceInfoEvent {
  @override
  List<Object?> get props => [];
}