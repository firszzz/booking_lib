part of 'employees_bloc.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();
}

class EmployeesLoadingState extends EmployeesState {
  @override
  List<Object> get props => [];
}

class EmployeesLoadedState extends EmployeesState {
  final List<User> employees;

  const EmployeesLoadedState(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeesEmptyState extends EmployeesState {
  @override
  List<Object> get props => [];
}

class EmployeesErrorState extends EmployeesState {
  final String error;

  const EmployeesErrorState(this.error);

  @override
  List<Object> get props => [error];
}