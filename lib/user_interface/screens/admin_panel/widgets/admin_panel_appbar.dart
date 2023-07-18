import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:flutter/material.dart';

import '../../../../resources/styles.dart';

class AdminPanelAppbar extends StatelessWidget {
  final String avatarName;
  final String avatarSurname;
  final String name;
  final String position;
  final String role;

  const AdminPanelAppbar({
    Key? key,
    required this.avatarName,
    required this.avatarSurname,
    required this.name,
    required this.position,
    required this.role
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppColorStyles.orangeGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              const Text(
                'Панель администратора',
                style: AppTextStyles.adminPanelAppbarTitle,
              ),

              Card(
                color: context.theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.theme.cardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          avatarName.characters.first,
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          avatarSurname.characters.first,
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: context.theme.primaryColorLight,
                    ),
                  ),
                  subtitle: Text(
                    position,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: context.theme.primaryColorLight,
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: context.theme.primaryColorLight,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7.0),
                      child: Text(
                        role,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
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
