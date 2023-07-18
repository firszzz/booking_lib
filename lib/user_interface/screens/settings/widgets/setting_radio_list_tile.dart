import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';

import '../../../../cubit/preferences/preferences_cubit.dart';

class SettingRadioListTile extends StatelessWidget {
  final String title;
  final PreferencesCubit prefCubit;
  final ThemeMode themeMode;
  final String? subtitle;

  const SettingRadioListTile({
    Key? key,
    this.subtitle,
    required this.title,
    required this.prefCubit,
    required this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<ThemeMode>(
        title: Text(title),
        subtitle: (subtitle != null) ? Text(subtitle!) : null,
        value: themeMode,
        groupValue: prefCubit.state.themeMode,
        onChanged: (s) {
          prefCubit.changePreferences(prefCubit.state.copyWith(themeMode: themeMode));
        }
    );
  }
}
