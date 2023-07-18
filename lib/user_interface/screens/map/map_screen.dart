import 'package:atb_flutter_demo/bloc/map/map_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/resources/env.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/models/floor.dart';
import '../../../domain/models/office.dart';
import '../../../resources/assets.dart';

class MapScreen extends StatefulWidget {
  final Floor floor;
  static String routeName = '/map_screen';

  const MapScreen({
    Key? key,
    required this.floor,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Floor selectedFloor = Floor(id: 0, officeId: 0, floorNumber: 0, mapImage: '');

  NetworkImage getNetworkImage(String url, String authKey) {
    Map<String, String> header = {};
    header["Authorization"] = authKey;
    return NetworkImage(url, headers: header);
  }


  @override
  void initState() {
    selectedFloor = widget.floor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    final bloc = MapBloc()
      ..add(LoadMapEvent(
        officeId: Office.fromJson(preferencesCubit.state.office).id,
      ));
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Карты этажей'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColorStyles.orangeGradient,
            ),
          ),
        ),
        // backgroundColor: Colors.white,
        body: BlocBuilder<MapBloc, MapState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is MapLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MapLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownSearch<Floor>(
                      onChanged: (selected) {
                        setState(() {
                          selectedFloor = selected!;
                        });
                      },
                      popupProps: const PopupProps.menu(),
                      items: state.floors,
                      itemAsString: (Floor u) => u.floorNumber.toString(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
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
                      selectedItem: selectedFloor,
                    ),
                  ),
                  (selectedFloor.mapImage == '')
                      ? Column(
                          children: [
                            SvgPicture.asset(
                              AppSvgAssets.map,
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Карта отсутствует',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        )
                      : Image(
                          image: getNetworkImage(
                              '${AppUrls.baseUrl}/images/${selectedFloor.mapImage}',
                              state.basicAuth),
                          height: 400,
                        ),
                ],
              );
            } else if (state is MapErrorState) {
              return ShowError(textMessage: state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
