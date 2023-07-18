part of 'employees_bloc.dart';

abstract class EmployeesEvent extends Equatable {
  const EmployeesEvent();
}

class LoadEmployeesEvent extends EmployeesEvent {

  @override
  List<Object?> get props => throw UnimplementedError();
}
