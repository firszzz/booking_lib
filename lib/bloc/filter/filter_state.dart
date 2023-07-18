part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterLoadingState extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterLoadedState extends FilterState {
  final List<String> cities;
  final List<Office> offices;

  const FilterLoadedState({
    required this.cities,
    required this.offices,
  });

  @override
  List<Object> get props => [cities, offices];
}

class FilterErrorState extends FilterState {
  final String error;

  const FilterErrorState(this.error);

  @override
  List<Object> get props => [error];
}