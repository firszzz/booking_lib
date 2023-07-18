part of 'statistic_bloc.dart';

abstract class StatisticEvent extends Equatable {
  const StatisticEvent();
}

class LoadStatisticEvent extends StatisticEvent {
  final int idOffice;
  final String timeBegin;
  final String timeEnd;
  final String city;

  const LoadStatisticEvent({
    required this.idOffice,
    required this.timeBegin,
    required this.timeEnd,
    required this.city,
  });

  @override
  List<Object?> get props => [idOffice, timeBegin, timeEnd, city];
}

class ChangeOfficeStatisticEvent extends StatisticEvent {
  final int idOffice;
  final String timeBegin;
  final String timeEnd;
  final String city;

  const ChangeOfficeStatisticEvent({
    required this.idOffice,
    required this.timeBegin,
    required this.timeEnd,
    required this.city,
  });

  @override
  List<Object?> get props => [idOffice, timeBegin, timeEnd, city];
}