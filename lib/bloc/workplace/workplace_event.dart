part of 'workplace_bloc.dart';

abstract class WorkplaceEvent extends Equatable {
  const WorkplaceEvent();
}

class LoadWorkplaceEvent extends WorkplaceEvent {
  final int officeId;
  final bool type;
  final int floorId;
  final String sortBy;

  const LoadWorkplaceEvent({
    required this.officeId,
    required this.type,
    required this.floorId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [officeId, type, floorId, sortBy];
}

class RefreshWorkplaceEvent extends WorkplaceEvent {
  @override
  List<Object?> get props => [];
}

class UpdateWorkplaceEvent extends WorkplaceEvent {
  final bool type;
  final int floorId;
  final int officeId;
  final String sortBy;

  const UpdateWorkplaceEvent({
    required this.type,
    required this.floorId,
    required this.officeId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [type, floorId, officeId, sortBy];
}

class ChangeOfficeWorkplaceEvent extends WorkplaceEvent {
  final bool type;
  final int officeId;
  final String sortBy;

  const ChangeOfficeWorkplaceEvent({
    required this.type,
    required this.officeId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [type, officeId, sortBy];
}

class ChangeFloorWorkplaceEvent extends WorkplaceEvent {
  final int officeId;
  final bool type;
  final int floorId;
  final String sortBy;


  const ChangeFloorWorkplaceEvent({
    required this.officeId,
    required this.type,
    required this.floorId,
    required this.sortBy,

  });
  @override
  List<Object?> get props => [officeId, type, floorId, sortBy];
}