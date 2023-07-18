import 'package:atb_flutter_demo/bloc/profile/profile_bloc.dart';
import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:atb_flutter_demo/user_interface/screens/about_me/widgets/about_card.dart';
import 'package:atb_flutter_demo/user_interface/widgets/text_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../../widgets/profile_sliver_appbar.dart';
import '../login/login_screen.dart';

class AboutMeScreen extends StatelessWidget {
  static String routeName = '/about_me_screen';
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ProfileBloc()..add(LoadProfileEvent());
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoadedState) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  ProfileSliverAppbar(
                    avatar: TextUserAvatar(
                      name: state.user.name,
                      surname: state.user.surname,
                      fontSize: 64,
                    ),
                    userName: '${state.user.name} ${state.user.surname}',
                    role: state.user.position,
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        AboutMeItem(
                          title: 'Логин',
                          subtitle: state.user.login,
                          pathToIcon: Icons.person_pin,
                        ),
                        AboutMeItem(
                          title: 'Email',
                          subtitle: state.user.email,
                          pathToIcon: Icons.email,
                        ),
                        AboutMeItem(
                          title: 'Телефон',
                          subtitle: state.user.phone,
                          pathToIcon: Icons.phone,
                        ),
                        AboutMeItem(
                          title: 'Должность',
                          subtitle: state.user.position,
                          pathToIcon: Icons.person,
                        ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Подтверждение"),
                                content: const Text(
                                    "Вы уверены что хотите выйти из аккаунта?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      const storage = FlutterSecureStorage();
                                      storage.deleteAll();

                                      Navigator.pushNamedAndRemoveUntil(context,
                                          LoginScreen.routeName, (route) => false);
                                    },
                                    child: const Text("Да", style: TextStyle(color: AppColorStyles.atbOrange)),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text("Нет", style: TextStyle(color: AppColorStyles.atbOrange)),
                                  ),
                                ],
                              );
                            },
                          );

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.close,
                              color: AppColorStyles.red,
                            ),
                            Text(
                              'Выйти из аккаунта',
                              style: AppTextStyles.logOutButton,
                            ),
                          ],
                        )
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileErrorState) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    state.error,
                    style: AppTextStyles.errorMessage,
                  ),
                ),
              ),
            );
          }
          return const Center(
              child: Text('Неизвестная ошибка')
          );
        },
      ),
    );
  }
}
