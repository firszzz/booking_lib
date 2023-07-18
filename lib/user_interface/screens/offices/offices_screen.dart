import 'package:atb_flutter_demo/bloc/office/office_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/create_office_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/office_workplaces.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../internal/usecases/get_office_floors.dart';
import '../location/widgets/location_item.dart';

class OfficesScreen extends StatelessWidget {
  static const String routeName = 'office_screen';

  const OfficesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();
    final bloc = OfficeBloc()
      ..add(LoadOfficeEvent(preferencesCubit.state.adminCity));
    return BlocProvider(
      create: (context) => OfficeBloc(),
      child: Scaffold(
        // appBar: AppBar(),
        body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is OfficeLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is OfficeLoadedState) {
              return CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverAppBar(
                      title: const Text('Офисы АТБ'),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColorStyles.orangeGradient,
                        ),
                      ),
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        bloc.add(UpdateOfficesEvent(preferencesCubit.state.city));
                        preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                          adminCity: state.cities.first,
                        ));
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: DropdownSearch<String>(
                          onChanged: (selected) {
                            bloc.add(ChangeCityEvent(
                              cities: state.cities,
                              city: selected!,
                            ));

                            preferencesCubit.changePreferences(
                              preferencesCubit.state
                                  .copyWith(adminCity: selected),
                            );
                          },
                          popupProps: const PopupProps.menu(),
                          items: state.cities,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            textAlignVertical: TextAlignVertical.center,
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
                          selectedItem: preferencesCubit.state.adminCity,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 2),
                              child: LocationItem(
                                idOffice: 'Офис АТБ ${state.offices[index].id}',
                                timeWork:
                                    '${state.offices[index].timeBegin} - ${state.offices[index].timeEnd}',
                                address:
                                    '${state.offices[index].city}, ${state.offices[index].address}',
                                onTap: ()  async {

                                  List<Floor> floors = [];
                                  try {
                                    final data = await GetOfficeFloors().call(GetOfficeFloorsParams(state.offices[index].id));
                                    floors = data;
                                    preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                                      adminOffice: state.offices[index].toJson(),
                                      adminFloor: floors.first.toJson(),
                                    ));
                                    Navigator.pushNamed(context,  OfficeWorkplacesScreen.routeName,);

                                  } on DioError catch (e) {
                                    preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                                      adminOffice: state.offices[index].toJson(),
                                      adminFloor: Floor(id: 0, officeId: 0, floorNumber: 0, mapImage: '').toJson(),
                                    ));
                                    Navigator.pushNamed(context,  OfficeWorkplacesScreen.routeName,);
                                  }


                                },
                              ),
                            ),
                          );
                        },
                        childCount: state.offices.length,
                      ),
                    ),
                  ]);
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, CreateOfficeScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
            primary: AppColorStyles.orange,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),
          child: const Text('Создать офис'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
