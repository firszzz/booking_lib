import 'package:atb_flutter_demo/bloc/employees/employees_bloc.dart';
import 'package:atb_flutter_demo/user_interface/screens/employees/widgets/employee_reservations.dart';
import 'package:atb_flutter_demo/user_interface/screens/employees/widgets/employee_item.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/styles.dart';

class EmployeesScreen extends StatelessWidget {
  static const String routeName = 'employees_screen';

  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employeesBloc = EmployeesBloc()..add(LoadEmployeesEvent());
    return BlocProvider(
      create: (context) => employeesBloc,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Сотрудники'),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColorStyles.orangeGradient,
              ),
            ),
          ),
          body: BlocBuilder(
            bloc: employeesBloc,
            builder: (BuildContext context, state) {
              if (state is EmployeesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is EmployeesLoadedState) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0, left: 10.0, right: 10.0),
                              child: EmployeeItem(
                                name: '${state.employees[index].name} ${state.employees[index].surname}',
                                surname: state.employees[index].surname,
                                login: state.employees[index].login,
                                email: state.employees[index].email,
                                phone: state.employees[index].phone,
                                position: state.employees[index].position,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EmployeeReservations(
                                              id: state.employees[index].id.toString(),
                                            name: state.employees[index].name,
                                            surname: state.employees[index].surname,
                                            position: state.employees[index].position,
                                            login: state.employees[index].login,
                                            email: state.employees[index].email,
                                            phone: state.employees[index].phone,
                                          ),
                                      ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        childCount: state.employees.length,
                      ),
                    ),
                  ],
                );
              }
              if (state is EmployeesErrorState) {
                return ShowError(textMessage: state.error);
              }
              return ShowError(textMessage: state.toString());
            },
          )),
    );
  }
}
