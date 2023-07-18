import 'package:atb_flutter_demo/bloc/statistic/statistic_bloc.dart';
import 'package:atb_flutter_demo/domain/models/statistic.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../cubit/preferences/preferences_cubit.dart';
import '../../../domain/models/office.dart';
import '../../../resources/styles.dart';

class StatisticScreen extends StatefulWidget {
  static const String routeName = '/statistic';

  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();
    String city = preferencesCubit.state.city;
    int idOffice = Office.fromJson(preferencesCubit.state.office).id;

    String now = DateTime.now().toString();
    String previous = DateTime.now().add(const Duration(days: -30)).toString();
    String today = now.substring(0, now.toString().indexOf('.'));
    String previousMonth = previous.substring(0, previous.indexOf('.'));

    final bloc = StatisticBloc()
      ..add(
        LoadStatisticEvent(
            idOffice: idOffice,
            timeBegin: previousMonth,
            timeEnd: today,
            city: city),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColorStyles.orangeGradient,
          ),
        ),
      ),
      body: BlocProvider<StatisticBloc>(
        create: (context) => bloc,
        child: BlocBuilder<StatisticBloc, StatisticState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is StatisticLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.deepOrange),
                ),
              );
            }
            if (state is StatisticLoadedState) {
              var selected = state.listOffices.firstWhere((element) => element.id == idOffice).address;

              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        DropdownSearch(
                          onChanged: (val) {
                            selected = val;
                            Office pickedOffice = state.listOffices.firstWhere(
                                (element) => element.address == selected);
                            idOffice = pickedOffice.id;
                            bloc.add(
                              ChangeOfficeStatisticEvent(
                                idOffice: idOffice,
                                timeBegin: previousMonth,
                                timeEnd: today,
                                city: city,
                              ),
                            );
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            textAlignVertical: TextAlignVertical.center,
                            baseStyle: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                          popupProps: const PopupProps.menu(),
                          items: state.listOfficeNames,
                          selectedItem: selected,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        state.listStatistic.isEmpty
                            ? Column(
                                children: [
                                  Text(
                                    "Нет данных статистики количества бронирований в офисе №$idOffice за прошлый месяц",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    "Данные статистики количества бронирований в офисе №$idOffice за прошлый месяц",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                        SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis:
                              NumericAxis(minimum: 0, maximum: 40, interval: 10),
                          series: <ChartSeries<Statistic, String>>[
                            BarSeries<Statistic, String>(
                              dataSource: state.listStatistic,
                              xValueMapper: (Statistic data, _) =>
                                  data.idWorkplace,
                              yValueMapper: (Statistic data, _) =>
                                  data.countReservations,
                              name: 'Сотрудники',
                              color: Colors.deepOrange,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
              body: Center(child: Text('Something went wrong: $state')),
            );
          },
        ),
      ),
    );
  }
}
