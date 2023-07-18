import 'package:atb_flutter_demo/bloc/filter/filter_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/data/api/request/jwt_auth.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/resources/assets.dart';

import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/booking_appbar.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/workplace_info.dart';

import 'package:atb_flutter_demo/user_interface/screens/booking/widgets/workplace_item.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../bloc/workplace/workplace_bloc.dart';

import '../../../domain/models/office.dart';
import '../../widgets/show_error.dart';
import '../booking_picker/booking_picker_screen.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    bool type = preferencesCubit.state.type;
    String city = preferencesCubit.state.city;
    int officeId = Office.fromJson(preferencesCubit.state.office).id;
    int floorId = Floor.fromJson(preferencesCubit.state.floor).id;
    String sortBy = preferencesCubit.state.sortBy;

    // bool type = context.select((PreferencesCubit cubit) => cubit.state.type);
    // String city = context.select((PreferencesCubit cubit) => cubit.state.city);
    // int officeId = context.select((PreferencesCubit cubit) => Office.fromJson(cubit.state.office).id);
    // int floorId = context.select((PreferencesCubit cubit) => Floor.fromJson(cubit.state.floor).id);
    // String sortBy = context.select((PreferencesCubit cubit) => cubit.state.sortBy);

    final filterBloc = FilterBloc()
      ..add(LoadFiltersEvent(
        city: city,
        idOffice: officeId,
      ));

    final workplaceBloc = WorkplaceBloc()
      ..add(
        LoadWorkplaceEvent(
          officeId: officeId,
          type: type,
          floorId: floorId,
          sortBy: sortBy,
        ),
      );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => filterBloc,
        ),
        BlocProvider(
          create: (context) => workplaceBloc,
        ),
      ],
      child: BlocBuilder<WorkplaceBloc, WorkplaceState>(
        bloc: workplaceBloc,
        builder: (context, state) {
          if (state is WorkplaceLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WorkplaceLoadedState) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: BookingAppBar(
                scaffoldKey: _scaffoldKey,
              ),
              endDrawer: Drawer(
                width: MediaQuery.of(context).size.width / 1.2,
                child: SafeArea(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              const Text(
                                'Фильтры',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 1,
                            color: AppColorStyles.mainGray,
                          )
                        ],
                      ),
                      BlocBuilder<FilterBloc, FilterState>(
                        bloc: filterBloc,
                        builder: (context, state) {
                          if (state is FilterLoadingState) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (state is FilterLoadedState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10.0),
                                    child: Text(
                                      'Город',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DropdownSearch<String>(
                                    onChanged: (selected) {
                                      preferencesCubit.changePreferences(
                                          preferencesCubit.state
                                              .copyWith(city: selected!));
                                      filterBloc.add(UpdateOfficesFilterEvent(
                                          city: selected));
                                    },
                                    popupProps: const PopupProps.menu(),
                                    items: state.cities,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      baseStyle: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      dropdownSearchDecoration: InputDecoration(
                                          prefix: Text('г. '),
                                          filled: true,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                    selectedItem: preferencesCubit.state.city,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10.0),
                                    child: Text(
                                      'Офис',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DropdownSearch<Office>(
                                    onChanged: (selected) {
                                      preferencesCubit.changePreferences(
                                          preferencesCubit.state.copyWith(
                                        office: selected!.toJson(),
                                      ));

                                      workplaceBloc
                                          .add(ChangeOfficeWorkplaceEvent(
                                        type: type,
                                        officeId: selected.id,
                                        sortBy: sortBy,
                                      ));
                                      Navigator.of(context).pop();
                                    },
                                    popupProps: const PopupProps.menu(),
                                    items: state.offices,
                                    itemAsString: (Office u) => u.address,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      baseStyle: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      dropdownSearchDecoration: InputDecoration(
                                          filled: true,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                    selectedItem: Office.fromJson(
                                        preferencesCubit.state.office),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is FilterErrorState) {
                            return ShowError(textMessage: state.error);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      workplaceBloc.add(
                        UpdateWorkplaceEvent(
                          type: type,
                          floorId:
                              Floor.fromJson(preferencesCubit.state.floor).id,
                          officeId: officeId,
                          sortBy: sortBy,
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<String>(
                              onChanged: (selected) {
                                (selected == 'Рабочее место')
                                    ? type = false
                                    : type = true;

                                preferencesCubit.changePreferences(
                                    preferencesCubit.state
                                        .copyWith(type: type));

                                workplaceBloc.add(ChangeFloorWorkplaceEvent(
                                  officeId: officeId,
                                  type: type,
                                  floorId: Floor.fromJson(
                                          preferencesCubit.state.floor)
                                      .id,
                                  sortBy: sortBy,
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
                                        borderSide: BorderSide.none)),
                              ),
                              selectedItem:
                                  (preferencesCubit.state.type == false)
                                      ? 'Рабочее место'
                                      : 'Переговорная',
                            ),
                          ),
                          Expanded(
                            child: DropdownSearch<Floor>(
                              onChanged: (selected) {
                                preferencesCubit.changePreferences(
                                    preferencesCubit.state.copyWith(
                                  floor: selected!.toJson(),
                                ));

                                workplaceBloc.add(ChangeFloorWorkplaceEvent(
                                  officeId: officeId,
                                  type: type,
                                  floorId: selected.id,
                                  sortBy: sortBy,
                                ));
                              },
                              popupProps: const PopupProps.menu(),
                              items: state.floors,
                              itemAsString: (Floor u) =>
                                  u.floorNumber.toString(),
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
                                        borderSide: BorderSide.none)),
                              ),
                              selectedItem:
                                  Floor.fromJson(preferencesCubit.state.floor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  (state.workplaces.isEmpty)
                      ? SliverPadding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2.5),
                          sliver: const SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'Нет мест',
                                style: AppTextStyles.emptyStateMessage,
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0, right: 7.0, left: 7.0),
                                child: WorkplaceItem(
                                  title: (state.workplaces[index].type)
                                      ? 'Переговорная ${state.workplaces[index].id}'
                                      : 'Рабочее место ${state.workplaces[index].id}',
                                  subtitle: state.workplaces[index].info,
                                  numLevel:
                                      'Этаж ${state.workplaces[index].floorLevel}',
                                  pathToImage: (state.workplaces[index].type)
                                      ? AppSvgAssets.bookingMeetingRoom
                                      : AppSvgAssets.bookingWorkplace,
                                  onTap: () async {
                                    const storage = FlutterSecureStorage();
                                    storage.write(
                                        key: 'idWorkPlace',
                                        value: state.workplaces[index].id
                                            .toString());
                                    storage.write(
                                        key: 'placeType',
                                        value: state.workplaces[index].type
                                            .toString());
                                    storage.write(
                                        key: 'numSeats',
                                        value: state
                                            .workplaces[index].seatsCount
                                            .toString());

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BookingBlocScreen()));
                                  },
                                  onTapInfo: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => WorkplaceInfo(
                                          imagesList: state.workplaces[index].imageNames,
                                          workplaceTitle: (state.workplaces[index].type)
                                              ? 'Переговорная ${state.workplaces[index].id}'
                                              : 'Рабочее место ${state.workplaces[index].id}',
                                          description:
                                              state.workplaces[index].info,
                                          idWorkplace: state.workplaces[index].id,
                                      ),
                                    );
                                  },
                                  onLongPress: () {},
                                ),
                              );
                            },
                            childCount: state.workplaces.length,
                          ),
                        ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WorkplaceErrorState) {
            return ShowError(
              textMessage: state.error,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
