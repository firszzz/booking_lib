import 'package:atb_flutter_demo/user_interface/screens/about_me/about_me_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/approve_reservation/approve_reservation_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/employees/employees_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/first_time_office/first_time_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/instructions/instructions_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/location/location.dart';
import 'package:atb_flutter_demo/user_interface/screens/login/login_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/main_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/map/map_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/create_office_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/office_workplaces.dart';
import 'package:atb_flutter_demo/user_interface/screens/offices/offices_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/settings/settings.dart';
import 'package:atb_flutter_demo/user_interface/screens/statistic/statistic_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/support_admin/support_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/support_message/support_message_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/welcome/welcome_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  AboutMeScreen.routeName: (context) => const AboutMeScreen(),
  SupportMessageScreen.routeName: (context) => const SupportMessageScreen(),
  OfficeWorkplacesScreen.routeName: (context) => const OfficeWorkplacesScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  LocationScreen.routeName: (context) => const LocationScreen(),
  EmployeesScreen.routeName: (context) => const EmployeesScreen(),
  SupportScreen.routeName: (context) => const SupportScreen(),
  OfficesScreen.routeName: (context) => const OfficesScreen(),
  CreateOfficeScreen.routeName: (context) => const CreateOfficeScreen(),
  StatisticScreen.routeName: (context) => const StatisticScreen(),
  InstructionsScreen.routeName: (context) => const InstructionsScreen(),
  ApproveReservationScreen.routeName: (context) => const ApproveReservationScreen(),
  FirstTimeScreen.routeName: (context) => const FirstTimeScreen(),
};