part of 'admin_workplace_bloc.dart';

abstract class AdminWorkplaceEvent extends Equatable {
  const AdminWorkplaceEvent();
}

class CreateWorkplaceEvent extends AdminWorkplaceEvent {
  final bool type;
  final int seatsCount;
  final String info;

  final int officeId;
  final int floorNumber;

  const CreateWorkplaceEvent({
    required this.type,
    required this.seatsCount,
    required this.info,
    required this.officeId,
    required this.floorNumber,
  });

  @override
  List<Object?> get props => [];
}
