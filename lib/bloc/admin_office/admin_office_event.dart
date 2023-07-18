part of 'admin_office_bloc.dart';

abstract class AdminOfficeEvent extends Equatable {
  const AdminOfficeEvent();
}

class CreateOfficeEvent extends AdminOfficeEvent {
  final String timeBegin;
  final String timeEnd;
  final bool access;
  final String city;
  final int numDay;
  final String address;
  final String timeZone;

  const CreateOfficeEvent({
    required this.timeBegin,
    required this.timeEnd,
    required this.access,
    required this.city,
    required this.numDay,
    required this.address,
    required this.timeZone,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}