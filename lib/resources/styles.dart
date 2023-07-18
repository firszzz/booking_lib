import 'package:flutter/material.dart';

abstract class AppColorStyles {
  static const Color atbOrange = Color.fromRGBO(254, 80, 0, 1);
  static const Color orange = Color.fromRGBO(255, 149, 0, 1);
  static const Color red = Color.fromRGBO(244, 67, 54, 1);
  static const Color green = Color.fromRGBO(75, 175, 80, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color gray = Color.fromRGBO(189, 197, 205, 1);
  static const Color mainGray = Color.fromRGBO(232, 232, 232, 1);
  static const Color secondGray = Color.fromRGBO(169, 169, 169, 1);
  static const Color whisper = Color.fromRGBO(247,248,250, 1);
  static const Color oldSilver = Color.fromRGBO(132,132,133, 1);

  static const Color cinder = Color.fromRGBO(9, 12, 23, 1);
  static const Color capeCod = Color.fromRGBO(66, 66, 66, 1);

  //dark mod
  // static const Color backgroundDark = Color.fromRGBO(48, 48, 48, 1);
  // static const Color cardDark = Color.fromRGBO(66, 66, 66, 1);
  static const Color backgroundDark = Color.fromRGBO(28, 28, 30, 1); //background
  static const Color cardDark = Color.fromRGBO(47, 47, 47, 1); //card

  //light mod
  // static const Color backgroundLight = Color.fromRGBO(255, 255, 255, 1);
  //static const Color cardLight = Color.fromRGBO(232, 232, 232, 1);
  static const Color backgroundLight = Color.fromRGBO(242, 241, 247, 1); //background
  static const Color cardLight = Color.fromRGBO(254, 254, 254, 1); //card

  //profile icons colors
  static const Color osloGray = Color.fromRGBO(143, 143, 145, 1);
  static const Color azure = Color.fromRGBO(0,126,252, 1);
  static const Color emerald = Color.fromRGBO(77, 189, 107, 1);
  static const Color rybOrange = Color.fromRGBO(246, 151, 9, 1);
  static const Color iris = Color.fromRGBO(88, 85, 215, 1);
  static const Color brilliantRed = Color.fromRGBO(248, 44, 50, 1);



  static const Color orangeGradientStart = Color.fromRGBO(255, 94, 58, 1);
  static const Color orangeGradientEnd = Color.fromRGBO(255, 149, 0, 1);

  static const Gradient orangeGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      orangeGradientStart,
      orangeGradientEnd,
    ],
  );

  static const Gradient blueGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromRGBO(29, 98, 240, 1),
      Color.fromRGBO(26, 213, 253, 1),
    ],
  );


}


abstract class AppTextStyles {

  static const TextStyle lightTitleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColorStyles.cinder,
  );

  static const TextStyle darkTitleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColorStyles.white,
  );




  static const TextStyle elevatedButton = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColorStyles.white,
  );

  static const TextStyle profileName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    // color: AppColorStyles.black,
  );

  static const TextStyle profileType = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorStyles.atbOrange,
  );

  static const TextStyle profileCard = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorStyles.cinder,
  );

  static const TextStyle aboutCardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    // color: AppColorStyles.black,
  );

  static const TextStyle aboutCardSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColorStyles.secondGray,
  );

  static const TextStyle filterTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColorStyles.cinder,
  );

  static const TextStyle filterResetAllButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColorStyles.orange,
  );

  static const TextStyle eventCardTimeToStart = TextStyle(
    color: AppColorStyles.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle eventCardTitle = TextStyle(
    // color: AppColorStyles.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle eventCardSubtitle = TextStyle(
    // color: Color.fromRGBO(0, 0, 0, 0.6),
    color: AppColorStyles.secondGray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle eventCardDateAndClock = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle appBar = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColorStyles.white,
  );

  static const TextStyle bookingCardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bookingCardSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColorStyles.secondGray,
  );

  static const TextStyle bookingCardLoadingPercent = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColorStyles.white,
  );

  static const TextStyle errorMessage = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColorStyles.red,
    decoration: TextDecoration.none
  );

  static const TextStyle homeEmptyStateMessage = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      // color: AppColorStyles.black,
  );

  static const TextStyle adminPanelAppbarTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColorStyles.white,
  );

  static const TextStyle logOutButton = TextStyle(
    fontSize: 18,
    color: AppColorStyles.red,
  );

  static const TextStyle emptyStateMessage = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

}