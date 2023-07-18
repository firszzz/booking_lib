import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/login/login_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/main_screen.dart';
import 'package:atb_flutter_demo/user_interface/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit/preferences/preferences_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const Spacer(flex: 3),
                      SvgPicture.asset(
                        (BlocProvider.of<PreferencesCubit>(context).state.themeMode == ThemeMode.dark)
                            ? 'assets/svg/atb_logo-orange_white.svg'
                            : 'assets/svg/atb_logo-orange_black.svg',
                      ),
                      const Spacer(),
                      const Text(
                        'Бронируйте место в офисе, не выходя из дома.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Image.asset('assets/images/booking-image.png'),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      GradientElevatedButton(
                        gradient: AppColorStyles.orangeGradient,
                        text: 'Продолжить',
                        width: 275,
                        onPressed: () async {
                          const storage = FlutterSecureStorage();
                          storage.deleteAll();

                          var login = await storage.read(key: 'login');
                          var password = await storage.read(key: 'password');

                          // storage.deleteAll();

                          if (login != null && password != null) {
                            Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (context) => false);
                          }
                          else {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
