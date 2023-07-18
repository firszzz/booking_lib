import 'package:atb_flutter_demo/bloc/reservations/reservations_bloc.dart';
import 'package:atb_flutter_demo/user_interface/widgets/profile_sliver_appbar.dart';
import 'package:atb_flutter_demo/user_interface/widgets/text_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/styles.dart';
import '../../../widgets/profile_clipper.dart';
import '../../../widgets/show_error.dart';
import '../../reservations/widgets/event_card.dart';

class EmployeeReservations extends StatelessWidget {
  final String id;
  final String name;
  final String surname;
  final String position;
  final String login;
  final String email;
  final String phone;

  static const Color trailingColor = AppColorStyles.secondGray;
  static const double _avatarSize = 160.0;
  static const double _backgroundHeight = 270.0;
  static const Gradient _backgroundGradient = AppColorStyles.orangeGradient;

  const EmployeeReservations({
    Key? key,
    required this.id,
    required this.name,
    required this.surname,
    required this.position,
    required this.login,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ReservationsBloc()..add(LoadReservationsEvent(id: id));
    return BlocProvider<ReservationsBloc>(
      create: (context) => bloc,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.48,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                            child: ClipPath(
                              clipper: ProfileClipper(),
                              child: Container(
                                height: _backgroundHeight,
                                decoration: const BoxDecoration(
                                  gradient: _backgroundGradient,
                                ),
                              ),
                            ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: _avatarSize,
                              height: _avatarSize,
                              child: TextUserAvatar(
                                name: name,
                                surname: surname,
                                fontSize: 64,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 7.0, right: 7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$name $surname',
                            style: AppTextStyles.profileName,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: Text(
                              position,
                              style: AppTextStyles.profileType,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Card(
                        child: ListTile(
                          title: const Text('Информация о пользователе'),
                          trailing: const Icon(Icons.info),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 10),
                                              child: Text(
                                                '$name $surname',
                                                style: const TextStyle(
                                                    fontSize: 24),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                ListTile(
                                                  title: const Text(
                                                    'Логин',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    login,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: trailingColor,
                                                    ),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.login,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: const Text(
                                                    'Email',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    email,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: trailingColor,
                                                    ),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.email,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: const Text(
                                                    'Телефон',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    phone,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: trailingColor,
                                                    ),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.phone,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: const Text(
                                                    'Логин',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    position,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: trailingColor,
                                                    ),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.person_pin,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Закрыть',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColorStyles
                                                            .atbOrange,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            CupertinoSliverRefreshControl(
              onRefresh: () async {
                // await Future.delayed(Duration(seconds: 2));
                bloc.add(RefreshReservationsEvent(id: id));
              },
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Бронирования пользователя',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            BlocBuilder<ReservationsBloc, ReservationsState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is ReservationsLoadingState) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                } else if (state is ReservationsLoadedState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, left: 7.0, right: 7.0),
                            child: Dismissible(
                              key: Key(state.reservations[index].id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                bloc.add(DeleteReservationsEvent(
                                    state.reservations[index].id.toString()));
                                print('delete is calling! lol');
                              },
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Подтверждение"),
                                      content: const Text(
                                          "Вы уверены что хотите удалить эту бронь?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text("Удалить", style: TextStyle(color: AppColorStyles.atbOrange)),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
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
                                timeToStart:
                                    state.reservations[index].timeToStart,
                                title:
                                    'Рабочее место ${state.reservations[index].idWorkPlace}',
                                subtitle: state.reservations[index].info,
                                date: state.reservations[index].date.toString(),
                                time:
                                    '${state.reservations[index].timeBegin} - ${state.reservations[index].timeEnd}',
                                adminPermissionStatus:
                                    state.reservations[index].adminPermission,
                                onPressed: () {
                                  print(
                                      'idReservations: ${state.reservations[index].id.toString()}');
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.reservations.length,
                    ),
                  );
                } else if (state is ReservationsEmptyState) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6),
                      child: const Center(
                        child: Text(
                          'Нет броней!',
                          style: AppTextStyles.homeEmptyStateMessage,
                        ),
                      ),
                    ),
                  );
                } else if (state is ReservationsErrorState) {
                  return SliverToBoxAdapter(child: ShowError(textMessage: state.error));
                }
                return SliverToBoxAdapter(
                    child: SliverToBoxAdapter(child: ShowError(textMessage: state.toString())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
