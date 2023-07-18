

import 'package:atb_flutter_demo/bloc/approve_reservations/approve_reservations_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/preferences/preferences_cubit.dart';
import '../../../resources/styles.dart';
import '../../widgets/show_error.dart';
import '../reservations/widgets/event_card.dart';

class ApproveReservationScreen extends StatefulWidget {
  static const String routeName = '/approve_reservations';
  const ApproveReservationScreen({Key? key}) : super(key: key);

  @override
  State<ApproveReservationScreen> createState() => _ApproveReservationScreenState();
}

class _ApproveReservationScreenState extends State<ApproveReservationScreen> {
  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();
    String city = preferencesCubit.state.city;

    var bloc = ApproveReservationsBloc()..add(LoadApproveReservationsEvent(city: city));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Одобрение бронирований'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColorStyles.orangeGradient,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              bloc.add(RefreshApproveReservationsEvent(city: city));
            },
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),

          BlocBuilder<ApproveReservationsBloc, ApproveReservationsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ApproveReservationsLoadingState) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 2.2),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              if (state is ApproveReservationsLoadedState) {
                if (state.reservations.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5, left: 10, right: 10),
                      child: const Center(
                        child: Text(
                          'Нет неподтвержденных бронирований',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 7.0, right: 7.0),
                            child: Dismissible(
                              key: Key(state.reservations[index].id.toString()),
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  bloc.add(ConfirmApproveReservationsEvent(state.reservations[index].id.toString()));
                                }
                                else if (direction == DismissDirection.endToStart) {
                                  bloc.add(DeleteApproveReservationsEvent(state.reservations[index].id.toString()));
                                }
                              },
                              confirmDismiss: (DismissDirection direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Подтверждение"),
                                        content: const Text(
                                            "Вы уверены что хотите удалить эту бронь?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(true),
                                            child: const Text("Удалить", style: TextStyle(color: AppColorStyles.atbOrange),),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text("Назад", style: TextStyle(color: AppColorStyles.atbOrange),),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                else if (direction == DismissDirection.startToEnd) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Подтверждение"),
                                        content: const Text(
                                            "Вы уверены что подтвердить эту бронь?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);

                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Бронирование успешно одобрено'),
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  textColor: AppColorStyles.orange,
                                                  onPressed: () {},
                                                ),
                                              );

                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: const Text("Подтвердить", style: TextStyle(color: AppColorStyles.atbOrange),),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text("Назад", style: TextStyle(color: AppColorStyles.atbOrange),),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              secondaryBackground: Container(
                                decoration: BoxDecoration(
                                  color: AppColorStyles.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 30.0),
                                    child: Icon(
                                      Icons.delete,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: AppColorStyles.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Icon(
                                      Icons.check,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              child: EventCard(
                                timeToStart: state.reservations[index].timeToStart,
                                title: state.reservations[index].isMeetingRoom
                                    ? 'Переговорная комната ${state.reservations[index].idWorkPlace}'
                                    : 'Рабочее место ${state.reservations[index].idWorkPlace}',
                                subtitle: 'Этаж ${state.reservations[index].officeLevel}',
                                date: state.reservations[index].date.toString(),
                                time: '${state.reservations[index].timeBegin} - ${state.reservations[index].timeEnd}',
                                adminPermissionStatus: state.reservations[index].adminPermission,
                                onPressed: () {
                                  print('idReservations: ${state.reservations[index].id.toString()}');
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.reservations.length,
                    ),
                  );
                }
              }
              if (state is ApproveReservationsErrorState) {
                return ShowError(textMessage: state.error);
              }
              return SliverToBoxAdapter(
                  child: ShowError(textMessage: state.toString()));
            },
          ),
        ],
      ),
    );
  }
}
