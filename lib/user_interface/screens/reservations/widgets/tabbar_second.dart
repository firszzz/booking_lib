import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/reservations/reservations_bloc.dart';
import '../../../../bloc/user_reservations/user_reservations_bloc.dart';
import '../../../../resources/styles.dart';
import '../../../widgets/show_error.dart';
import 'event_card.dart';

class TabBarSecond extends StatelessWidget {
  final UserReservationsBloc bloc;

  const TabBarSecond({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            // await Future.delayed(Duration(seconds: 2));
            bloc.add(RefreshUserReservationsEvent());
          },
        ),

        const SliverToBoxAdapter(
          child: SizedBox(
            height: 15,
          ),
        ),

        BlocBuilder<UserReservationsBloc, UserReservationsState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is UserReservationsLoadingState) {
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
            if (state is UserReservationsLoadedState) {
              if (state.unconfirmedReservations.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
                    child: const Center(
                      child: Text(
                        'Нет броней',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
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
                            key: Key(state.unconfirmedReservations[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection direction) {
                              bloc.add(DeleteUserReservations(state.unconfirmedReservations[index].id.toString()));
                              print('delete is calling! lol');
                            },
                            confirmDismiss: (DismissDirection direction) async {
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
                                        child: const Text("Удалить", style: TextStyle(color: AppColorStyles.atbOrange)),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text("Назад", style: TextStyle(color: AppColorStyles.atbOrange)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            background: Container(
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
                            child: EventCard(
                              timeToStart: state.unconfirmedReservations[index].timeToStart,
                              title: state.unconfirmedReservations[index].isMeetingRoom
                                  ? 'Переговорная комната ${state.unconfirmedReservations[index].idWorkPlace}'
                                  : 'Рабочее место ${state.unconfirmedReservations[index].idWorkPlace}',
                              subtitle: 'Этаж ${state.unconfirmedReservations[index].officeLevel}',
                              date: state.unconfirmedReservations[index].date.toString(),
                              time: '${state.unconfirmedReservations[index].timeBegin} - ${state.unconfirmedReservations[index].timeEnd}',
                              adminPermissionStatus: state.unconfirmedReservations[index].adminPermission,
                              onPressed: () {
                                print('idReservations: ${state.unconfirmedReservations[index].id.toString()}');
                              },
                              info: state.unconfirmedReservations[index].reservationDescription,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: state.unconfirmedReservations.length,
                  ),
                );
              }
            }
            if (state is UserReservationsErrorState) {
              return ShowError(textMessage: state.error);
            }
            return SliverToBoxAdapter(
                child: ShowError(textMessage: state.toString()));
          },
        ),
      ],
    );
  }
}
