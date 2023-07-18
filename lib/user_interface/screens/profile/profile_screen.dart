import 'package:atb_flutter_demo/preferences/models/preferences.dart';
import 'package:atb_flutter_demo/user_interface/screens/about_me/about_me_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/instructions/instructions_screen.dart';
import 'package:atb_flutter_demo/user_interface/screens/location/location.dart';
import 'package:atb_flutter_demo/user_interface/screens/settings/settings.dart';
import 'package:atb_flutter_demo/user_interface/screens/support_message/support_message_screen.dart';
import 'package:atb_flutter_demo/user_interface/widgets/show_error.dart';
import 'package:atb_flutter_demo/user_interface/widgets/text_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../cubit/preferences/preferences_cubit.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../internal/dependencies/repository_module.dart';
import '../../../resources/styles.dart';
import '../../widgets/profile_sliver_appbar.dart';
import 'widgets/setting_item.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeBloc = context.read<ThemeBloc>();
    final preferencesCubit = context.read<PreferencesCubit>();

    final user = RepositoryModule.userRepository();
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
                        BlocBuilder<PreferencesCubit, Preferences>(
                          bloc: preferencesCubit,
                          builder: (context, preferences) {
                            return SettingsItem(
                              icons: Icons.auto_mode,
                              iconStyle: IconStyle(
                                iconsColor: Colors.white,
                                withBackground: true,
                                backgroundColor: AppColorStyles.cinder,
                              ),
                              title: 'Тёмный режим',
                              onTap: () async {
                                if (preferences.themeMode == ThemeMode.dark) {
                                  preferencesCubit.changePreferences(preferences
                                      .copyWith(themeMode: ThemeMode.light));
                                } else {
                                  preferencesCubit.changePreferences(preferences
                                      .copyWith(themeMode: ThemeMode.dark));
                                }
                                // themeBloc.add(ThemeChangedEvent());
                              },
                              trailing:
                                  (preferences.themeMode == ThemeMode.light)
                                      ? const Icon(Icons.light_mode)
                                      : const Icon(Icons.dark_mode),
                            );
                          },
                        ),
                        const Divider(),
                        SettingsItem(
                          icons: Icons.manage_accounts,
                          iconStyle: IconStyle(
                            iconsColor: AppColorStyles.white,
                            withBackground: true,
                            backgroundColor: AppColorStyles.azure,
                          ),
                          title: 'Аккаунт',
                          subtitle: 'Посмотреть данные',
                          onTap: () {
                            Navigator.pushNamed(
                                context, AboutMeScreen.routeName);
                          },
                        ),
                        SettingsItem(
                          icons: Icons.support,
                          iconStyle: IconStyle(
                            iconsColor: AppColorStyles.white,
                            withBackground: true,
                            backgroundColor: AppColorStyles.emerald,
                          ),
                          title: 'Поддержка',
                          subtitle: 'Написать сообщение',
                          onTap: () {
                            Navigator.pushNamed(
                                context, SupportMessageScreen.routeName);
                          },
                        ),
                        SettingsItem(
                          icons: Icons.settings,
                          iconStyle: IconStyle(
                            iconsColor: AppColorStyles.white,
                            withBackground: true,
                            backgroundColor: AppColorStyles.rybOrange,
                          ),
                          title: 'Настройки',
                          subtitle: 'Настройте приложение',
                          onTap: () {
                            Navigator.pushNamed(
                                context, SettingsScreen.routeName);
                          },
                        ),
                        SettingsItem(
                          icons: Icons.info,
                          iconStyle: IconStyle(
                            iconsColor: AppColorStyles.white,
                            withBackground: true,
                            backgroundColor: AppColorStyles.osloGray,
                          ),
                          title: 'Книга сотрудника',
                          subtitle: 'Справочная информация',
                          onTap: () {
                            Navigator.pushNamed(
                                context, InstructionsScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileErrorState) {
            return ShowError(
              textMessage: state.toString(),
            );
          }
          return ShowError(
            textMessage: state.toString(),
          );
        },
      ),
    );
  }
}
