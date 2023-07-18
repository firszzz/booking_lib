part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();
}

class MapLoadingState extends MapState {
  @override
  List<Object> get props => [];
}

class MapLoadedState extends MapState {
  final List<Floor> floors;
  final String basicAuth;

  const MapLoadedState({
    required this.floors,
    required this.basicAuth,
  });

  @override
  List<Object> get props => [];
}

class MapErrorState extends MapState {
  final String error;

  const MapErrorState(this.error);

  @override
  List<Object> get props => [error];
}