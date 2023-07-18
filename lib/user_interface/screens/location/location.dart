import 'package:atb_flutter_demo/bloc/office/office_bloc.dart';
import 'package:atb_flutter_demo/user_interface/screens/location/widgets/location_item.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/styles.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = 'location_screen';

  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final officeBloc = OfficeBloc()..add(LoadOfficeEvent('Владивосток'));
    return BlocProvider(
      create: (context) => officeBloc,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Офис',
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColorStyles.orangeGradient,
              ),
            ),
          ),
          body: BlocBuilder<OfficeBloc, OfficeState>(builder: (context, state) {
            if (state is OfficeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OfficeLoadedState) {
              return CustomScrollView(slivers: [
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
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                          child: LocationItem(
                            idOffice: 'Офис ${state.offices[index].id}',
                            timeWork: '${state.offices[index].timeBegin} - ${state.offices[index].timeEnd}',
                            address: '${state.offices[index].city}, ${state.offices[index].address}',
                            onTap: () {  },
                          ),
                        ),
                      );
                    },
                    childCount: state.offices.length,
                  ),
                ),
              ]);
            }
            if (state is OfficeErrorState) {
              return ShowError(
                textMessage: state.error,
              );
            }
            return ShowError(
              textMessage: state.toString(),
            );
          })),
    );
  }
}
