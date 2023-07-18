part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadMapEvent extends MapEvent {
  final int officeId;

  const LoadMapEvent({
    required this.officeId,
  });

  @override
  List<Object?> get props => [officeId];
}