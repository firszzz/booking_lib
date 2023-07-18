part of 'office_bloc.dart';

abstract class OfficeEvent extends Equatable {
  const OfficeEvent();
}

class LoadOfficeEvent extends OfficeEvent {
  final String city;

  const LoadOfficeEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class ChangeCityEvent extends OfficeEvent {
  final List<String> cities;
  final String city;

  const ChangeCityEvent({
    required this.cities,
    required this.city,
  });

  @override
  List<Object?> get props => [city];
}

class UpdateOfficesEvent extends OfficeEvent {
  final String city;

  const UpdateOfficesEvent(this.city);

  @override
  List<Object?> get props => [];
}