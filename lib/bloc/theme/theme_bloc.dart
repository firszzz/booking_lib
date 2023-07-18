import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: appThemeData[AppTheme.values[0]]!)) {
    on<ThemeChangedEvent>((event, emit) {
      (state.themeData == appThemeData[AppTheme.LightTheme])
          ? emit(ThemeState(themeData: appThemeData[AppTheme.DarkTheme]!))
          : emit(ThemeState(themeData: appThemeData[AppTheme.LightTheme]!));
    });
  }
}
