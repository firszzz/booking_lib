import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/reservations/reservations_bloc.dart';
import '../../../../bloc/user_reservations/user_reservations_bloc.dart';
import '../../../../resources/styles.dart';
import '../../../widgets/show_error.dart';
import 'event_card.dart';

class TabBarFirst extends StatelessWidget {
  final UserReservationsBloc bloc;

  const TabBarFirst({
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
              if (state.confirmedReservations.isEmpty) {
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
                            key: Key(state.confirmedReservations[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection direction) {
                              bloc.add(DeleteUserReservations(state.confirmedReservations[index].id.toString()));
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
                              timeToStart: state.confirmedReservations[index].timeToStart,
                              title: state.confirmedReservations[index].isMeetingRoom
                                  ? 'Переговорная комната ${state.confirmedReservations[index].idWorkPlace}'
                                  : 'Рабочее место ${state.confirmedReservations[index].idWorkPlace}',
                              subtitle: 'Этаж ${state.confirmedReservations[index].officeLevel}',
                              date: state.confirmedReservations[index].date.toString(),
                              time: '${state.confirmedReservations[index].timeBegin} - ${state.confirmedReservations[index].timeEnd}',
                              adminPermissionStatus: state.confirmedReservations[index].adminPermission,
                              onPressed: () {
                                print('idReservations: ${state.confirmedReservations[index].id.toString()}');
                              },
                              info: (state.confirmedReservations[index].isMeetingRoom)
                              ? state.confirmedReservations[index].reservationDescription
                              : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: state.confirmedReservations.length,
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
