part of 'office_workplaces_bloc.dart';

abstract class OfficeWorkplacesEvent extends Equatable {
  const OfficeWorkplacesEvent();
}

class LoadOfficeWorkplacesEvent extends OfficeWorkplacesEvent {
  final bool type;
  final int officeId;
  final String sortBy;

  const LoadOfficeWorkplacesEvent({
    required this.type,
    required this.officeId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [type, officeId, sortBy];
}

class UpdateOfficeWorkplacesEvent extends OfficeWorkplacesEvent {
  final bool type;
  final int officeId;
  final int floorId;
  final String sortBy;

  const UpdateOfficeWorkplacesEvent({
    required this.type,
    required this.officeId,
    required this.floorId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [type, officeId, floorId, sortBy];
}

class DeleteOfficeWorkplacesEvent extends OfficeWorkplacesEvent {
  final int id;

  const DeleteOfficeWorkplacesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeFloorWorkplacesEvent extends OfficeWorkplacesEvent {
  final bool type;
  final int officeId;
  final int floorId;
  final String sortBy;

  const ChangeFloorWorkplacesEvent({
    required this.type,
    required this.officeId,
    required this.floorId,
    required this.sortBy,
  });
  @override
  List<Object?> get props => [type, officeId, floorId, sortBy];

}