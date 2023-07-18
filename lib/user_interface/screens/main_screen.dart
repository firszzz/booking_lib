import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/admin_panel/admin_panel_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/booking/booking_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/reservations/reservations_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main_screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currId = 0;
  bool isAdmin = false;
  List<Widget> _widgets = [
    const ReservationsScreen(),
    BookingScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const storage = FlutterSecureStorage();
      final role = await storage.read(key: 'role');

      if (role!.toLowerCase() == 'true') {
        setState(() {
          isAdmin = true;
        });
      }

      if (isAdmin) {
        setState(() {
          _widgets.insert(
            0,
            const AdminPanelScreen()
          );
        });
      }
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currId = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets.elementAt(_currId),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currId,
        onTap: onTabTapped,
        items: isAdmin ? const [
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Админ'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Главная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue),
            label: 'Бронирование',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ] :
        const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Главная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue),
            label: 'Бронирование',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
