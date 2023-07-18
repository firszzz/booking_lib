import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,
}

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorStyles.orange,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorStyles.backgroundLight,
    primaryColor: AppColorStyles.cinder,
    primaryColorLight: AppColorStyles.white,
    primaryColorDark: AppColorStyles.white,
    shadowColor: AppColorStyles.mainGray,
    cardColor: AppColorStyles.cardLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorStyles.white,
      unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.7),
      selectedItemColor: AppColorStyles.atbOrange,
    ),
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.lightTitleLarge,
    ),
  ),

  AppTheme.DarkTheme: ThemeData(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorStyles.atbOrange,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorStyles.backgroundDark,
    primaryColor: AppColorStyles.white,
    primaryColorLight: AppColorStyles.capeCod,
    primaryColorDark: AppColorStyles.cinder,
    shadowColor: Colors.transparent,
    cardColor: AppColorStyles.cardDark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
      unselectedItemColor: AppColorStyles.white,
      selectedItemColor: AppColorStyles.atbOrange,
    ),
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.darkTitleLarge,
    ),

  ),
};

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
}

/*uses*/
//  final color = context.theme.backgroundColor;