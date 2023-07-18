import 'package:atb_flutter_demo/bloc/first_time/first_time_bloc.dart';
import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/assets.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/main_screen.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_elevated_button.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/models/office.dart';

class FirstTimeScreen extends StatelessWidget {
  static const String routeName = '/first_time';
  const FirstTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();
    final bloc = FirstTimeBloc()
      ..add(LoadFirstTimeEvent());
    return BlocProvider(
      create: (context) => bloc,
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<FirstTimeBloc, FirstTimeState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is FirstTimeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FirstTimeLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      child: SvgPicture.asset(AppSvgAssets.office),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Text(
                            'Выберите город',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownSearch<String>(
                            onChanged: (selected) {
                              preferencesCubit.changePreferences(
                                  preferencesCubit.state.copyWith(
                                    city: selected,
                                    adminCity: selected,
                                  ));
                              bloc.add(ChangeCityFirstTimeEvent(selected!));
                            },
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              modalBottomSheetProps: ModalBottomSheetProps(
                                backgroundColor: context.theme.cardColor,
                              ),
                            ),
                            items: state.cities,
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
                            selectedItem: preferencesCubit.state.city,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'Выберите офис',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownSearch<Office>(
                            onChanged: (selected) {
                              preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                                office: selected!.toJson(),
                                adminOffice: selected.toJson(),
                              ));
                              bloc.add(SetFloorFirstTimeEvent(
                                city: preferencesCubit.state.city,
                                officeId: Office.fromJson(preferencesCubit.state.office).id,
                              ));
                            },
                            popupProps: const PopupProps.menu(),
                            items: state.offices,
                            itemAsString: (Office u) => u.address,
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
                            selectedItem: Office.fromJson(preferencesCubit.state.office),
                          ),
                        ],
                      ),
                    ),

                    GradientElevatedButton(
                      text: 'Продолжить',
                      onPressed: () {
                        preferencesCubit.changePreferences(preferencesCubit.state.copyWith(
                          floor: state.floors.first.toJson(),
                          adminFloor: state.floors.first.toJson(),
                        ));

                        final snackBar = SnackBar(
                          content: const Text('Вход выполнен успешно'),
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: AppColorStyles.atbOrange,
                            onPressed: () {},
                          ),
                          duration: const Duration(seconds: 1),
                        );

                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);

                        Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
                      },
                      gradient: AppColorStyles.orangeGradient,
                    ),
                  ],
                );
              } else if (state is FirstTimeErrorState) {
                return ShowError(textMessage: state.error);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
