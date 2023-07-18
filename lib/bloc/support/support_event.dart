part of 'support_bloc.dart';

abstract class SupportEvent extends Equatable {
  const SupportEvent();
}

class LoadSupportEvent extends SupportEvent {
  @override
  List<Object?> get props => [];
}

class ChangeSupportEvent extends SupportEvent {
  final String choice;

  const ChangeSupportEvent(this.choice);

  @override
  List<Object?> get props => [choice];
}

class ChangeStatusEvent extends SupportEvent {
  final int id;
  final String choice;
  const ChangeStatusEvent(this.id, this.choice);

  @override
  List<Object?> get props => [id, choice];
}