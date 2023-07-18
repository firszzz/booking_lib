import 'package:atb_flutter_demo/bloc/workplace/workplace_bloc.dart';
import 'package:atb_flutter_demo/resources/assets.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/workplace_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../resources/styles.dart';
import '../../../widgets/show_error.dart';
import '../../booking_picker/booking_picker_screen.dart';

class WorkplaceBuilder extends StatelessWidget {
  final WorkplaceBloc bloc;

  const WorkplaceBuilder({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkplaceBloc, WorkplaceState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is WorkplaceLoadingState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 2.2),
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is WorkplaceLoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 6.0, right: 7.0, left: 7.0),
                  child: WorkplaceItem(
                    title: (state.workplaces[index].type == false)
                        ? 'Рабочее место ${state.workplaces[index].id}'
                        : 'Переговорная ${state.workplaces[index].id}',
                    subtitle: state.workplaces[index].info,
                    numLevel: 'Этаж ${state.workplaces[index].floorLevel}',
                    pathToImage: AppSvgAssets.bookingWorkplace,
                    onTap: () async {
                      const storage = FlutterSecureStorage();
                      storage.write(
                          key: 'idWorkPlace',
                          value: state.workplaces[index].id.toString());
                      storage.write(
                          key: 'placeType',
                          value: state.workplaces[index].type.toString());
                      storage.write(
                          key: 'numSeats',
                          value: state.workplaces[index].seatsCount.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookingBlocScreen()));
                    },
                    onTapInfo: () {},
                    onLongPress: () {},
                  ),
                );
              },
              childCount: state.workplaces.length,
            ),
          );
        }
        if (state is WorkplaceEmptyState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5),
              child: const Center(
                child: Text(
                  'Этаж пуст',
                  style: AppTextStyles.homeEmptyStateMessage,
                ),
              ),
            ),
          );
        }
        if (state is WorkplaceErrorState) {
          return SliverToBoxAdapter(
            child: ShowError(textMessage: state.error),
          );
        }
        return SliverToBoxAdapter(
            child: ShowError(
          textMessage: state.toString(),
        ));
      },
    );
  }
}
