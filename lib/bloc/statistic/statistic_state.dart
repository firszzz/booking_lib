part of 'statistic_bloc.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();
}

class StatisticLoadingState extends StatisticState {
  @override
  List<Object> get props => [];
}

class StatisticLoadedState extends StatisticState {
  final List<Statistic> listStatistic;
  final List<Office> listOffices;
  final List<String> listOfficeNames;

  const StatisticLoadedState(this.listStatistic, this.listOffices, this.listOfficeNames);

  @override
  List<Object?> get props => [listStatistic, listOffices, listOfficeNames];
}