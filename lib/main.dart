import 'package:atb_flutter_demo/preferences/models/preferences.dart';
import 'package:atb_flutter_demo/preferences/services/preferences_service.dart';
import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/routes.dart';
import 'package:atb_flutter_demo/user_interface/screens/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'cubit/preferences/preferences_cubit.dart';

void main() async {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PreferencesCubit>(
      future: buildBloc(),
      builder: (context, blocSnapshot) {
        if (blocSnapshot.hasData && blocSnapshot.data != null) {
          return BlocProvider<PreferencesCubit>(
            create: (context) => blocSnapshot.data!,
            child: BlocBuilder<PreferencesCubit, Preferences>(
              builder: (context, preferences) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'ATB APP',
                  theme: appThemeData[AppTheme.LightTheme],
                  darkTheme: appThemeData[AppTheme.DarkTheme],
                  themeMode: preferences.themeMode,
                  initialRoute: WelcomeScreen.routeName,
                  routes: routes,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink(
          child: CupertinoActivityIndicator(
            color: AppColorStyles.atbOrange,
            radius: 30,
          ),
        );
      },
    );
  }

  Future<PreferencesCubit> buildBloc() async {
    final prefs = await SharedPreferences.getInstance();
    final service = MyPreferencesService(prefs);
    return PreferencesCubit(service, service.get());
  }
}
