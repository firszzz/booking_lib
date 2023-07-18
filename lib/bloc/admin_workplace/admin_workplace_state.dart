part of 'admin_workplace_bloc.dart';

abstract class AdminWorkplaceState extends Equatable {
  const AdminWorkplaceState();
}

class AdminWorkplaceInitial extends AdminWorkplaceState {
  @override
  List<Object> get props => [];
}


class AdminWorkplaceAdding extends AdminWorkplaceState {
  @override
  List<Object?> get props => [];
}

class AdminWorkplaceAdded extends AdminWorkplaceState{
  @override
  List<Object?> get props =>[];

}

class AdminWorkplaceError extends AdminWorkplaceState {
  final String error;

  const AdminWorkplaceError(this.error);
  @override
  List<Object?> get props => [error];
}