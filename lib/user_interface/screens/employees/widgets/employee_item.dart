import 'dart:math';

import 'package:atb_flutter_demo/resources/app_themes.dart';
import 'package:flutter/material.dart';

import '../../../../resources/styles.dart';

class EmployeeItem extends StatelessWidget {
  final String name;
  final String surname;
  final String login;
  final String email;
  final String phone;
  final String position;
  final VoidCallback onTap;

  static const Color leadingColor = AppColorStyles.white;
  static const Color trailingColor = AppColorStyles.secondGray;

  const EmployeeItem({
    Key? key,
    required this.name,
    required this.surname,
    required this.login,
    required this.email,
    required this.phone,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.theme.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name.characters.first,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                surname.characters.first,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            position,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColorStyles.orange,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 24
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Логин',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  login,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: trailingColor,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.login,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: trailingColor,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.email,
                                ),
                              ),

                              ListTile(
                                title: const Text(
                                  'Телефон',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  phone,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: trailingColor,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.phone,
                                ),
                              ),

                              ListTile(
                                title: const Text(
                                  'Логин',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  position,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: trailingColor,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.person_pin,
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                      'Закрыть',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColorStyles.atbOrange,
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
