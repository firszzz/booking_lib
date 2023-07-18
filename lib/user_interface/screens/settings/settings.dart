import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/preferences/models/preferences.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/settings/widgets/setting_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/restore_button.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefCubit = context.read<PreferencesCubit>();
    return BlocBuilder<PreferencesCubit, Preferences>(
      builder: (context, preferences) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Настройки'),
            automaticallyImplyLeading: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColorStyles.orangeGradient
              ),
            ),
            /*actions: [
              RestoreButton(prefCubit: prefCubit),
            ],*/
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text(
                    'Тема приложения',
                    style: TextStyle(
                      fontSize: 22
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  child: Column(
                    children: [
                      SettingRadioListTile(
                          title: 'Тёмная тема',
                          prefCubit: prefCubit,
                          themeMode: ThemeMode.dark,
                      ),
                      SettingRadioListTile(
                        title: 'Светлая тема',
                        prefCubit: prefCubit,
                        themeMode: ThemeMode.light,
                      ),
                      SettingRadioListTile(
                        title: 'Системная тема',
                        subtitle: 'Тема зависит от выбранной в системе',
                        prefCubit: prefCubit,
                        themeMode: ThemeMode.system,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}


