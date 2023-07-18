import 'package:atb_flutter_demo/bloc/profile/profile_bloc.dart';
import 'package:atb_flutter_demo/user_interface/screens/admin_panel/widgets/admin_panel_appbar.dart';
import 'package:atb_flutter_demo/user_interface/screens/admin_panel/widgets/admin_panel_item.dart';
import 'package:atb_flutter_demo/user_interface/screens/approve_reservation/approve_reservation_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/employees/employees_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/offices_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/statistic/statistic_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/support_admin/support_screen.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ProfileBloc()..add(LoadProfileEvent());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoadedState) {
              return CustomScrollView(
                slivers: [
                  AdminPanelAppbar(
                    avatarName: state.user.name,
                    avatarSurname: state.user.surname,
                    name: '${state.user.name} ${state.user.surname}',
                    position: state.user.position,
                    role: 'АДМИН',
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        AdminPanelItem(
                          icon: Icons.person_search,
                          title: 'Сотрудники',
                          onTap: () {
                            Navigator.pushNamed(
                                context, EmployeesScreen.routeName);
                          },
                        ),
                        AdminPanelItem(
                          icon: Icons.place,
                          title: 'Офисы',
                          onTap: () {
                            Navigator.pushNamed(
                                context, OfficesScreen.routeName);
                          },
                        ),
                        AdminPanelItem(
                          icon: Icons.check_circle_outlined,
                          title: 'Одобрение бронирований',
                          onTap: () {
                            Navigator.pushNamed(
                                context, ApproveReservationScreen.routeName);
                          },
                        ),
                        AdminPanelItem(
                          icon: Icons.support_agent,
                          title: 'Поддержка',
                          onTap: () {
                            Navigator.pushNamed(
                                context, SupportScreen.routeName);
                          },
                        ),
                        AdminPanelItem(
                          icon: Icons.line_axis_sharp,
                          title: 'Статистика',
                          onTap: () {
                            Navigator.pushNamed(
                                context, StatisticScreen.routeName);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ProfileErrorState) {
              return ShowError(textMessage: state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
