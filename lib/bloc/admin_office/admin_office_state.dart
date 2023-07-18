part of 'admin_office_bloc.dart';

abstract class AdminOfficeState extends Equatable {
  const AdminOfficeState();
}

class AdminOfficeInitial extends AdminOfficeState {
  @override
  List<Object> get props => [];
}

class AdminOfficeAdding extends AdminOfficeState {
  @override
  List<Object?> get props => [];
}

class AdminOfficeAdded extends AdminOfficeState{
  @override
  List<Object?> get props =>[];

}

class AdminOfficeError extends AdminOfficeState {
  final String error;

  const AdminOfficeError(this.error);
  @override
  List<Object?> get props => [error];
}