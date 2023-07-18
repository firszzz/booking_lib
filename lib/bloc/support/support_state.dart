part of 'support_bloc.dart';

abstract class SupportState extends Equatable {
  const SupportState();
}

class SupportLoadingState extends SupportState {
  @override
  List<Object?> get props => [];
}

class SupportLoadedState extends SupportState {
  final List<SupportMessage> listMessages;
  const SupportLoadedState(this.listMessages);

  @override
  List<Object?> get props => [listMessages];
}