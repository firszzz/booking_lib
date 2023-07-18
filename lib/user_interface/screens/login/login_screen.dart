import 'dart:convert';

import 'package:atb_flutter_demo/cubit/preferences/preferences_cubit.dart';
import 'package:atb_flutter_demo/data/api/request/jwt_auth.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/first_time_office/first_time_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../bloc/theme/theme_bloc.dart';
import '../../../data/api/request/make_authorization.dart';
import '../../../resources/app_themes.dart';
import '../../widgets/gradient_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String _email = '';
  String _pass = '';
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool hasFocus1 = false;
  bool hasFocus2 = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      SvgPicture.asset(
                        (BlocProvider.of<PreferencesCubit>(context).state.themeMode == ThemeMode.dark)
                            ? 'assets/svg/atb_logo-orange_white.svg'
                            : 'assets/svg/atb_logo-orange_black.svg',
                      ),
                      const SizedBox(height: 110),
                      Focus(
                        onFocusChange: (val) {
                          setState(() {
                            hasFocus1 = val;
                          });
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          initialValue: _email,
                          decoration: InputDecoration(
                            labelText: 'Логин',
                            hintText: 'Введите логин',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: hasFocus1 ? AppColorStyles.orange : context.theme.primaryColor
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColorStyles.atbOrange,
                                )
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _email = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Focus(
                        onFocusChange: (val) {
                          setState(() {
                            hasFocus2 = val;
                          });
                        },
                        child: TextFormField(
                          key: _passwordFieldKey,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          initialValue: _pass,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            hintText: 'Введите пароль',
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: hasFocus2 ? AppColorStyles.orange : context.theme.primaryColor
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColorStyles.atbOrange,
                              )
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _toggle();
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _obscureText ? context.theme.primaryColor : AppColorStyles.atbOrange,
                              ),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _pass = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      /*Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Забыли пароль?',
                              style: TextStyle(color: atbMainColor)),
                        ),
                      ),*/
                      const SizedBox(
                        height: 115,
                      ),
                      GradientElevatedButton(
                          gradient: AppColorStyles.orangeGradient,
                          width: 275,
                          text: 'Войти',
                          onPressed: () async {

                            JwtAuthController().auth(login: _email, password: _pass).then((value) {
                              const storage = FlutterSecureStorage();

                              if (value?.statusCode == 400) {
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Проверьте правильность введеных данных'),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    textColor: AppColorStyles.atbOrange,
                                    onPressed: () {},
                                  ),
                                  duration: const Duration(seconds: 1),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              else {
                                final preferencesCubit = context.read<PreferencesCubit>();

                                storage.deleteAll();

                                storage.write(key: 'login', value: _email);
                                storage.write(key: 'password', value: _pass);
                                storage.write(key: 'accessToken', value: value?.data['accessToken']);
                                storage.write(key: 'refreshToken', value: value?.data['refreshToken']);

                                // String accessToken = utf8.decode(base64Url.decode(value.data['accessToken']));
                                Map<String, dynamic> decodedToken = JwtDecoder.decode(value?.data['accessToken']);
                                List<dynamic> roles = decodedToken['roles'];

                                storage.write(key: 'idEmployee', value: decodedToken['employeeId'].toString());
                                storage.write(key: 'role', value: (roles.first == 'ROLE_ADMIN') ? 'true' : 'false');

                                if (preferencesCubit.state.city == 'Город не выбран') {
                                  Navigator.pushNamedAndRemoveUntil(context, FirstTimeScreen.routeName, (route) => false);
                                }
                                else {
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
                                }
                              }

                            });
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
