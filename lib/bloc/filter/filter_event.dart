part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class LoadFiltersEvent extends FilterEvent {
  final String city;
  final int idOffice;

  const LoadFiltersEvent({
    required this.city,
    required this.idOffice,
  });

  @override
  List<Object?> get props => [city, idOffice];
}

class UpdateOfficesFilterEvent extends FilterEvent {
  final String city;

  const UpdateOfficesFilterEvent({
    required this.city,
  });

  @override
  List<Object?> get props => [city];
}