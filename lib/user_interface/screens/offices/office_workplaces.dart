import 'package:atb_flutter_demo/bloc/office_workplaces/office_workplaces_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/domain/models/office.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/workplace_info_admin.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/workplace_item.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/create_workplace.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/map_admin.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/assets.dart';

class OfficeWorkplacesScreen extends StatelessWidget {
  static const String routeName = 'office_workplaces_screen';

  const OfficeWorkplacesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();


    bool adminType = preferencesCubit.state.adminType;
    Floor selectedFloor = Floor.fromJson(preferencesCubit.state.adminFloor);
    int floorId = Floor.fromJson(preferencesCubit.state.adminFloor).id;
    int officeId = Office.fromJson(preferencesCubit.state.adminOffice).id;


    final bloc = OfficeWorkplacesBloc()..add(
        LoadOfficeWorkplacesEvent(
          type: preferencesCubit.state.adminType,
          officeId: Office.fromJson(preferencesCubit.state.adminOffice).id,
          sortBy: 'id',
        ),
      );

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<OfficeWorkplacesBloc, OfficeWorkplacesState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is OfficeWorkplacesLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is OfficeWorkplacesLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Места АТБ'),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColorStyles.orangeGradient,
                  ),
                ),
              ),
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      bloc.add(UpdateOfficeWorkplacesEvent(
                          type: adminType,
                          officeId: officeId,
                          floorId: floorId,
                          sortBy: 'id',
                      ));
                      // await Future.delayed(Duration(seconds: 2));
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<Floor>(
                            onChanged: (selected) {
                              selectedFloor = selected!;
                              preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                                adminFloor: selected.toJson(),
                              ));
                              bloc.add(UpdateOfficeWorkplacesEvent(
                                type: adminType,
                                officeId: officeId,
                                floorId: selected.id,
                                sortBy: 'id',
                              ));


                            },
                            popupProps: const PopupProps.menu(),
                            items: state.floors,
                            itemAsString: (Floor o) => o.floorNumber.toString(),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              textAlignVertical: TextAlignVertical.center,
                              baseStyle: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              dropdownSearchDecoration: InputDecoration(
                                prefix: Text('Этаж '),
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            selectedItem: Floor.fromJson(preferencesCubit.state.adminFloor),
                          ),
                        ),
                        Expanded(
                          child: DropdownSearch<String>(
                            onChanged: (selected) {
                              (selected == 'Рабочее место')
                                  ? adminType = false
                                  : adminType = true;

                              preferencesCubit.changePreferences(
                                  preferencesCubit.state
                                      .copyWith(adminType: adminType));

                              bloc.add(UpdateOfficeWorkplacesEvent(
                                type: adminType,
                                officeId: officeId,
                                floorId: floorId,
                                sortBy: 'id',
                              ));
                            },
                            popupProps: const PopupProps.menu(),
                            items: const ['Рабочее место', 'Переговорная'],
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              textAlignVertical: TextAlignVertical.center,
                              baseStyle: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            selectedItem: (preferencesCubit.state.adminType == false)
                                    ? 'Рабочее место'
                                    : 'Переговорная',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 6.0, right: 7.0, left: 7.0),
                          child: Dismissible(
                            key: Key(state.workplaces[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection direction) {
                              bloc.add(DeleteOfficeWorkplacesEvent(
                                  state.workplaces[index].id));
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Подтверждение"),
                                    content: const Text(
                                        "Вы уверены что хотите удалить это место?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Удалить",
                                            style: TextStyle(
                                                color:
                                                    AppColorStyles.atbOrange)),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Назад",
                                            style: TextStyle(
                                                color:
                                                    AppColorStyles.atbOrange)),
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
                            child: WorkplaceItem(
                              title: (state.workplaces[index].type == false)
                                  ? 'Рабочее место ${state.workplaces[index].id}'
                                  : 'Переговорная ${state.workplaces[index].id}',
                              subtitle: state.workplaces[index].info,
                              numLevel:
                                  'Этаж ${state.workplaces[index].floorLevel}',
                              pathToImage: (state.workplaces[index].type)
                                  ? AppSvgAssets.bookingMeetingRoom
                                  : AppSvgAssets.bookingWorkplace,
                              onTap: () {},
                              onTapInfo: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return WorkplaceInfoAdmin(
                                      imagesList: state.workplaces[index].imageNames,
                                      workplaceTitle: (state.workplaces[index].type == false)
                                          ? 'Рабочее место ${state.workplaces[index].id}'
                                          : 'Переговорная ${state.workplaces[index].id}',
                                      description:
                                          state.workplaces[index].info,
                                      idWorkplace: state.workplaces[index].id,
                                  );
                                }));
                              },
                              onLongPress: () {},
                            ),
                          ),
                        );
                      },
                      childCount: state.workplaces.length,
                    ),
                  ),
                ],
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /*ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapAdminScreen(
                              officeId: Office.fromJson(preferencesCubit.state.adminOffice).id,
                              mapImage: '',
                              floor: Floor.fromJson(preferencesCubit.state.adminFloor),
                            ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColorStyles.orange,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Карты этажей'),
                  ),*/
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateWorkplace(
                              bloc: bloc,
                              ifOffice: officeId,
                              floors: state.floors,
                            )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColorStyles.orange,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Создать место'),
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          } else if (state is OfficeWorkplacesErrorState) {
            return ShowError(textMessage: state.error);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
