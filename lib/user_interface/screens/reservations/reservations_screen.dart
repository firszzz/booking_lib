import 'package:atb_flutter_demo/bloc/reservations/reservations_bloc.dart';
import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/reservations/widgets/event_card.dart';
import 'package:atb_flutter_demo/user_interface/screens/reservations/widgets/tabbar_first.dart';
import 'package:atb_flutter_demo/user_interface/screens/reservations/widgets/tabbar_second.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_sliver_appbar.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_reservations/user_reservations_bloc.dart';
import '../../../internal/dependencies/repository_module.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = UserReservationsBloc()..add(LoadUserReservationsEvent());
    return BlocProvider<UserReservationsBloc>(
      create: (context) => bloc,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Ваши бронирования'),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColorStyles.orangeGradient,
              ),
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  // icon: Icon(Icons.cloud_outlined),
                  child: Text(
                    'Подтвержденные',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColorStyles.white,
                    ),
                  ),
                ),
                Tab(
                  // icon: Icon(Icons.beach_access_sharp),
                  child: Text(
                    'Неподтвердженные',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColorStyles.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TabBarFirst(bloc: bloc),
              TabBarSecond(bloc: bloc),
            ],
          ),
        ),
      ),
    );
  }
}

